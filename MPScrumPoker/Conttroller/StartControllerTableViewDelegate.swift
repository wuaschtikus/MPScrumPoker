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
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.appDelegate.isAdvertising == true {
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
