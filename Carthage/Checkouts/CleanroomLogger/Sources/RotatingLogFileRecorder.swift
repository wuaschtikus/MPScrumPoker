//
//  RotatingLogFileRecorder.swift
//  CleanroomLogger
//
//  Created by Evan Maloney on 5/14/15.
//  Copyright © 2015 Gilt Groupe. All rights reserved.
//

import Foundation

/**
 A `LogRecorder` implementation that maintains a set of daily rotating log
 files, kept for a user-specified number of days.

 - important: A `RotatingLogFileRecorder` instance assumes full control over
 the log directory specified by its `directoryPath` property. Please see the
 initializer documentation for details.
*/
public class RotatingLogFileRecorder: LogRecorderBase
{
    /** The number of days for which the receiver will retain log files
     before they're eligible for pruning. */
    public let daysToKeep: Int

    /** The filesystem path to a directory where the log files will be
     stored. */
    public let directoryPath: String

    private static let filenameFormatter: NSDateFormatter = {
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd'.log'"
        return fmt
    }()

    private var mostRecentLogTime: NSDate?
    private var currentFileRecorder: FileLogRecorder?

    /**
     Initializes a new `RotatingLogFileRecorder` instance.

     - warning: The `RotatingLogFileRecorder` expects to have full control over
     the contents of its `directoryPath`. Any file not recognized as an active 
     log file will be deleted during the automatic pruning process, which may
     occur at any time. Therefore, be __extremely careful__ when constructing
     the value passed in as the `directoryPath`.

     - parameter daysToKeep: The number of days for which log files should be
     retained.

     - parameter directoryPath: The filesystem path of the directory where the
     log files will be stored. Please note the warning above regarding the
     `directoryPath`.

     - parameter formatters: An array of `LogFormatter`s to use for formatting
     log entries to be recorded by the receiver. Each formatter is consulted in
     sequence, and the formatted string returned by the first formatter to
     yield a non-`nil` value will be recorded. If every formatter returns `nil`,
     the log entry is silently ignored and not recorded.
    */
    public init(daysToKeep: Int, directoryPath: String, formatters: [LogFormatter] = [ReadableLogFormatter()])
    {
        self.daysToKeep = daysToKeep
        self.directoryPath = directoryPath

        super.init(formatters: formatters)
    }

    /**
     Returns a string representing the filename that will be used to store logs
     recorded on the given date.

     - parameter date: The `NSDate` for which the log file name is desired.

     - returns: The filename.
    */
    public class func logFilenameForDate(date: NSDate)
        -> String
    {
        return filenameFormatter.stringFromDate(date)
    }

    private class func fileLogRecorderForDate(date: NSDate, directoryPath: String, formatters: [LogFormatter])
        -> FileLogRecorder?
    {
        let fileName = self.logFilenameForDate(date)
        let filePath = (directoryPath as NSString).stringByAppendingPathComponent(fileName)
        return FileLogRecorder(filePath: filePath, formatters: formatters)
    }

    private func fileLogRecorderForDate(date: NSDate)
        -> FileLogRecorder?
    {
        return self.dynamicType.fileLogRecorderForDate(date, directoryPath: directoryPath, formatters: formatters)
    }

    private func isDate(firstDate: NSDate, onSameDayAs secondDate: NSDate)
        -> Bool
    {
        let firstDateStr = self.dynamicType.logFilenameForDate(firstDate)
        let secondDateStr = self.dynamicType.logFilenameForDate(secondDate)
        return firstDateStr == secondDateStr
    }

    /**
     Attempts to create—if it does not already exist—the directory indicated
     by the `directoryPath` property.
     
     - throws: If the function fails to create a directory at `directoryPath`.
     */
    public func createLogDirectory()
        throws
    {
        let url = NSURL(fileURLWithPath: directoryPath, isDirectory: true)

        try NSFileManager.defaultManager().createDirectoryAtURL(url, withIntermediateDirectories: true, attributes: nil)
    }

    /**
     Called by the `LogReceptacle` to record the specified log message.

     - note: This function is only called if one of the `formatters` associated
     with the receiver returned a non-`nil` string for the given `LogEntry`.

     - parameter message: The message to record.

     - parameter entry: The `LogEntry` for which `message` was created.

     - parameter currentQueue: The GCD queue on which the function is being
     executed.

     - parameter synchronousMode: If `true`, the receiver should record the log
     entry synchronously and flush any buffers before returning.
    */
    public override func recordFormattedMessage(message: String, forLogEntry entry: LogEntry, currentQueue: dispatch_queue_t, synchronousMode: Bool)
    {
        if mostRecentLogTime == nil || !self.isDate(entry.timestamp, onSameDayAs: mostRecentLogTime!) {
            prune()
            currentFileRecorder = fileLogRecorderForDate(entry.timestamp)
        }
        mostRecentLogTime = entry.timestamp

        currentFileRecorder?.recordFormattedMessage(message, forLogEntry: entry, currentQueue: queue, synchronousMode: synchronousMode)
    }

    /**
     Deletes any expired log files (and any other detritus that may be hanging
     around inside our `directoryPath`).

     - warning: Any file within the `directoryPath` not recognized as an active
     log file will be deleted during pruning.
    */
    public func prune()
    {
        // figure out what files we'd want to keep, then nuke everything else
        let cal = NSCalendar.currentCalendar()
        var date = NSDate()
        var filesToKeep = Set<String>()
        for _ in 0..<daysToKeep {
            let filename = self.dynamicType.logFilenameForDate(date)
            filesToKeep.insert(filename)
            date = cal.dateByAddingUnit(.Day, value: -1, toDate: date, options: .WrapComponents)!
        }

        do {
            let fileMgr = NSFileManager.defaultManager()
            let filenames = try fileMgr.contentsOfDirectoryAtPath(directoryPath)

            let pathsToRemove = filenames
                .filter { return !$0.hasPrefix(".") }
                .filter { return !filesToKeep.contains($0) }
                .map { return (self.directoryPath as NSString).stringByAppendingPathComponent($0) }

            for path in pathsToRemove {
                do {
                    try fileMgr.removeItemAtPath(path)
                }
                catch {
                    print("Error attempting to delete the unneeded file <\(path)>: \(error)")
                }
            }
        }
        catch {
            print("Error attempting to read directory at path <\(directoryPath)>: \(error)")
        }
    }
}

