//
//  ViewController.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 29.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import CleanroomLogger

class ViewController: UIViewController, MPCManagerDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func startStopAdvertizing(sender: AnyObject) {
        self.startStopAdvertising(sender)
    }
    
    // MARK: - Properties
    
    let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    var isAdvertising: Bool!
    var startTableViewDatasource:StartControllerTableViewDatasoure! {
        willSet {
            self.tableView.dataSource = newValue
            self.tableView.reloadData()
        }
    }
    var startTableViewDelegate:StartControllerTableViewDelegate! {
        willSet {
            self.tableView.delegate = newValue
        }
    }
    
    
    // MARK:  Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup multipeer
        
        self.appDelegate.mpcManager.delegate = self
        self.appDelegate.mpcManager.browser.startBrowsingForPeers()
        self.isAdvertising = true
        
        // setup tableview
        
        self.prepareTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private
    
    func prepareTableView() {
        self.startTableViewDelegate = StartControllerTableViewDelegate(startController: self)
        self.startTableViewDatasource = StartControllerTableViewDatasoure(startController: self)
    }
    
    // MARK: - MCPManagerDelegate
    
    func foundPeer(peerId:MCPeerID) {
        Log.debug?.message("Found peer: \(peerId.displayName)")
        self.startTableViewDatasource = StartControllerTableViewDatasoure(startController: self)
        self.appDelegate.mpcManager.browser.invitePeer(
            peerId,
            toSession: appDelegate.mpcManager.session,
            withContext: nil,
            timeout: AppConstants.Multipeer.invitationTimeout)
        self.view.makeToast("Invited pear: \(peerId.displayName)")
    }
    
    func lostPeer(peerId:MCPeerID) {
        Log.debug?.message("Lost peer: \(peerId.displayName)")
    }
    
    func startStopAdvertising(sender: AnyObject) {
        
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
        
        alert.addAction(UIAlertAction(
            title: AppConstants.Alert.NoButtonTitle,
            style: UIAlertActionStyle.Default,
            handler: nil))
        
        alert.addAction(
            UIAlertAction(
                title: AppConstants.Alert.OkButtonTitle,
                style: UIAlertActionStyle.Default) {
                (alertAction) -> Void in
                
                if self.isAdvertising == true {
                    self.appDelegate.mpcManager.advertiser.stopAdvertisingPeer()
                }  else {
                    self.appDelegate.mpcManager.advertiser.startAdvertisingPeer()
                }
                
                self.isAdvertising = !self.isAdvertising
            })
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func invitationWasReceived(fromPeer: String) {
        Log.debug?.message("Recieved invite")
        self.appDelegate.mpcManager.invitationHandler(true, self.appDelegate.mpcManager.session)
        
    }
    
    func connectedWithPeer(peerID: MCPeerID) {
        Log.debug?.message("Connected with Peer: \(peerID.displayName)")
    }
}

