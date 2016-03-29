//
//  StartController.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 29.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class StartControllerTableViewDelegate : NSObject, UITableViewDelegate {
    
    // MARK: - Properties
    
    var startController:ViewController!
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // MARK: - Lifecycle
    
    init(startController:ViewController) {
        self.startController = startController
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedPeer = appDelegate.mpcManager.foundPeers[indexPath.row] as MCPeerID
        
        self.appDelegate.mpcManager.browser.invitePeer(selectedPeer, toSession: appDelegate.mpcManager.session, withContext: nil, timeout: 20)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.startController.isAdvertising == true {
            let header = UIViewLoadingHeader.loadFromNibNamed("UIViewLoadingHeader") as! UIViewLoadingHeader
            header.activityIndicator.startAnimating()
            return header
        } else {
            return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
