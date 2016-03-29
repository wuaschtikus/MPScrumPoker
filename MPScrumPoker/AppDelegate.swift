//
//  AppDelegate.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 29.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit
import CleanroomLogger
import MultipeerConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MPCManagerDelegate {
    
    var window: UIWindow?
    
    var mpcManager: MPCManager!
    var isAdvertising: Bool!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // setup multipeer
        
        self.mpcManager = MPCManager()
        
        self.mpcManager.delegate = self
        self.mpcManager.browser.startBrowsingForPeers()
        self.mpcManager.advertiser.startAdvertisingPeer()
        self.isAdvertising = true
        
        Log.enable(minimumSeverity: .Verbose,
                   debugMode: false,
                   verboseDebugMode: false,
                   timestampStyle: .Default,
                   severityStyle: .Xcode,
                   showCallSite: true,
                   showCallingThread: false,
                   suppressColors: false,
                   filters: [])
        
        
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        self.mpcManager.session.disconnect()
    }
    
    // MARK: - MPCManagerDelegate
    
    func foundPeer(peerId:MCPeerID) {
        Log.debug?.message("Found peer: \(peerId.displayName)")
        NSNotificationCenter.defaultCenter().postNotificationName(
            SettingsController.NotificationName.ReloadTableView.rawValue,
            object: self)
    }
    
    func lostPeer(peerId:MCPeerID) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            SettingsController.NotificationName.ReloadTableView.rawValue,
            object: self)
    }
    
    func invitationWasReceived(fromPeer: MCPeerID) {
        Log.debug?.message("Accepted Invite from peer: \(fromPeer.displayName)")
        NSNotificationCenter.defaultCenter().postNotificationName(
            SettingsController.NotificationName.ReloadTableView.rawValue,
            object: self)
    }
    
    func connectedWithPeer(peerID: MCPeerID) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            SettingsController.NotificationName.ReloadTableView.rawValue,
            object: self)
        
    }
    
    func startStopAdvertising() {
        
        var title: String
        var msg: String
        if self.isAdvertising == true {
            title = AppConstants.Alert.StopAdvertising.title
            msg = AppConstants.Alert.StopAdvertising.msg
        } else {
            title = AppConstants.Alert.StartAdvertising.title
            msg = AppConstants.Alert.StartAdvertising.msg
        }
        
        let alert = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(
            UIAlertAction(
                title: AppConstants.Alert.NoButtonTitle,
                style: UIAlertActionStyle.Default,
                handler: nil))
        
        alert.addAction(
            UIAlertAction(
                title: AppConstants.Alert.OkButtonTitle,
            style: UIAlertActionStyle.Default) {
                (alertAction) -> Void in
                
                //                if self.isAdvertising == true {
                //                    self.appDelegate.mpcManager.advertiser.stopAdvertisingPeer()
                //                }  else {
                //                    self.appDelegate.mpcManager.advertiser.startAdvertisingPeer()
                //                }
                //
                //                self.isAdvertising = !self.isAdvertising
                //                self.tableView.reloadData()
            })
        
        //        self.window?.presentViewController(alert, animated: true, completion: nil)
    }
}

