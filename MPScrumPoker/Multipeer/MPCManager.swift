//
//  MPCManager.swift
//  MPCRevisited
//
//  Created by Gabriel Theodoropoulos on 11/1/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import CleanroomLogger

protocol MPCManagerDelegate {
    func foundPeer(peerId:MCPeerID)
    func lostPeer(peerId:MCPeerID)
    func invitationWasReceived(fromPeer: String)
    func connectedWithPeer(peerID: MCPeerID)
}

class MPCManager: NSObject, MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate {
    
    // MARK: - Properties
    
    let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    /// Delegate which informs about certain session events
    var delegate: MPCManagerDelegate?

    /// Multipeer Session
    var session: MCSession!
    
    /// This is your own peer
    var peer: MCPeerID!
    
    /// Browser for multipeer session
    var browser: MCNearbyServiceBrowser!
    
    /// Advertiser for multipeer session
    var advertiser: MCNearbyServiceAdvertiser!
    
    /// References found peer in this multipeer session
    var foundPeers = [MCPeerID]()

    /// Is called when another user wants to invite you
    var invitationHandler:  ((Bool, MCSession) -> Void)!
    
    // MARK:  Lifecycle
    
    override init() {
        super.init()
        
        self.peer = MCPeerID(displayName: UIDevice.currentDevice().name)
        
        self.session = MCSession(peer: peer)
        self.session.delegate = self
        
        self.browser = MCNearbyServiceBrowser(
            peer: peer,
            serviceType: AppConstants.Multipeer.serviceType)
        self.browser.delegate = self
        
        self.advertiser = MCNearbyServiceAdvertiser(
            peer: peer,
            discoveryInfo: nil,
            serviceType: AppConstants.Multipeer.serviceType)
        self.advertiser.delegate = self
    }
    
    
    // MARK: - MCNearbyServiceBrowserDelegate
    
    func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        
        Log.debug?.message("Found peer with PeerID: \(peerID.displayName)")
        
        foundPeers.append(peerID)
        delegate?.foundPeer(peerID)
    }
    
    func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        
        Log.debug?.message("Lost peer with PeerID: \(peerID.displayName)")
        
        let index = self.foundPeers.indexOf { (currentPeer) -> Bool in
            return currentPeer.displayName == peerID.displayName
        }
        
        if let actualIndex = index {
            self.foundPeers.removeAtIndex(actualIndex)
            Log.debug?.message("Removed peerID from found peers")
        }
        
        delegate?.lostPeer(peerID)
    }
    
    func browser(browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: NSError) {
        Log.error?.message("Error when starting to browse for peers: \(error)")
    }
    
    // MARK: - MCNearbyServiceAdvertiserDelegate
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: ((Bool, MCSession) -> Void)) {
        
        Log.debug?.message("Did recieve invitation from: \(peerID.displayName)")
        
        self.invitationHandler = invitationHandler
        delegate?.invitationWasReceived(peerID.displayName)
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: NSError) {
        Log.debug?.message("Error when start to advertise: \(error.localizedDescription)")
    }
    
    // MARK: - MCSessionDelegate
    
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        switch state {
        case MCSessionState.Connected:
            Log.debug?.message("Connected to session with \(session.connectedPeers.count) available peers")
            delegate?.connectedWithPeer(peerID)
            
        case MCSessionState.Connecting:
            Log.debug?.message("Connecting to session with myPeerID: \(session.myPeerID)")
            
        default:
            Log.debug?.message("Did not connect to session with myPeerID: \(session.myPeerID)")
        }
    }
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        let dictionary: [String: AnyObject] = ["data": data, "fromPeer": peerID]
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            "receivedMPCDataNotification", object: dictionary)
    }
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) { }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) { }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) { }
    
    // MARK: Custom method implementation
    
    func sendData(dictionaryWithData dictionary: Dictionary<String, String>, toPeer targetPeer: MCPeerID) {
        let dataToSend = NSKeyedArchiver.archivedDataWithRootObject(dictionary)
        let peersArray = NSArray(object: targetPeer)
        
        try! session.sendData(dataToSend,
                              toPeers: peersArray as! [MCPeerID],
                              withMode: MCSessionSendDataMode.Reliable)
    }
}
