//
//  ViewController.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 29.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit
import MultipeerConnectivity

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
    
    func foundPeer() {
        print("Found peer")
        self.startTableViewDatasource = StartControllerTableViewDatasoure(startController: self)
    }
    
    func lostPeer() {
        print("Lost peer")
    }
    
    func startStopAdvertising(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "", message: "Change Visibility", preferredStyle: UIAlertControllerStyle.Alert)
        
        var actionTitle: String
        if isAdvertising == true {
            actionTitle = "Make me invisible to others"
        }
        else{
            actionTitle = "Make me visible to others"
        }
        
        let visibilityAction: UIAlertAction = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            
            if self.isAdvertising == true {
                self.appDelegate.mpcManager.advertiser.stopAdvertisingPeer()
            }
            else{
                self.appDelegate.mpcManager.advertiser.startAdvertisingPeer()
            }
            
            self.isAdvertising = !self.isAdvertising
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        
        actionSheet.addAction(visibilityAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func invitationWasReceived(fromPeer: String) {
        let alert = UIAlertController(title: "", message: "\(fromPeer) wants to chat with you.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let acceptAction: UIAlertAction = UIAlertAction(title: "Accept", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.appDelegate.mpcManager.invitationHandler(true, self.appDelegate.mpcManager.session)
        }
        
        let declineAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            self.appDelegate.mpcManager.invitationHandler(false, self.appDelegate.mpcManager.session)
        }
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func connectedWithPeer(peerID: MCPeerID) {
        print("Connected with Peer: \(peerID.displayName)")
    }
}

