//
//  XcodeColorsTextColorizer.swift
//  CleanroomLogger
//
//  Created by Evan Maloney on 12/18/15.
//  Copyright © 2015 Gilt Groupe. All rights reserved.
//

import Darwin.C.stdlib

/**
 A `TextColorizer` implementation that applies 
 [XcodeColors](https://github.com/robbiehanson/XcodeColors/)-compatible 
 formatting to log messages.
 */
public struct XcodeColorsTextColorizer: TextColorizer
{
    /**
     Initializes a new instance if and only if XcodeColors is installed and
     enabled, as indicated by the presence of the `XcodeColors` environment
     variable. (Unless the value of this variable is the string `YES`, this
     initializer will fail.)
    */
    public init?()
    {
        let env = getenv("XcodeColors")

        guard env != nil else {
            return nil
        }

        guard let str = String.fromCString(env) else {
            return nil
        }

        guard str == "YES" else {
            return nil
        }
    }

    /**
     Applies XcodeColors-style formatting appropriate for the given
     `LogSeverity` to the passed-in string.

     - parameter string: The string to be colorized.

     - parameter foreground: An optional foreground color to apply to `string`.

     - parameter background: An optional background color to apply to `string`.

     - returns: A version of `string` with the appropriate color formatting
     applied.
     */
    public func colorizeString(str: String, foreground: Color?, background: Color?)
        -> String
    {
        let esc = "\u{001b}["

        var prefix = ""
        var suffix = ""
        if let fgColor = foreground {
            prefix += "\(esc)\(fgColor.asXcodeColorsForegroundString);"
            suffix = "\(esc);"
        }
        if let bgColor = background {
            prefix += "\(esc)\(bgColor.asXcodeColorsbackgroundString);"
            suffix = "\(esc);"
        }

        return "\(prefix)\(str)\(suffix)"
    }
}

extension Color
{
    /// A comma-separated string representation of the red, green and blue
    /// components of the color in base-10 integers.
    private var asXcodeColorsString: String {
        return "\(r),\(g),\(b)"
    }

    /// An XcodeColors-style string representation usable as a foreground color.
    private var asXcodeColorsForegroundString: String {
        return "fg\(asXcodeColorsString)"
    }

    /// An XcodeColors-style string representation usable as a background color.
    private var asXcodeColorsbackgroundString: String {
        return "bg\(asXcodeColorsString)"
    }
}

