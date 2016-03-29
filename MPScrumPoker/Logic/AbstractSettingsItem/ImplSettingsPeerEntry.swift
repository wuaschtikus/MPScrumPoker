//
//  ImplSettingsPeerEntry.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 29.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ImplSettingsPeerEntry : SettingsEntryProtocol {
    
    var peerId:MCPeerID!
    
    init(peerId:MCPeerID) {
        self.peerId = peerId
    }
    
    func createCell(tableView:UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCellPeer") as! UITableViewCellPeer
        cell.peerNameLabel.text = self.peerId.displayName
        
        return cell
    }
}