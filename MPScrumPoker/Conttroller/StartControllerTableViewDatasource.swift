//
//  StartControllerTableViewDatasource.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 29.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit
import CleanroomLogger

class StartControllerTableViewDatasoure : NSObject, UITableViewDataSource {
    
    // MARK: - Properties
    
    var startController:ViewController!
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // MARK: - Lifecycle
    
    init(startController:ViewController) {
        
        Log.debug?.message("Initialized StartControllerTableViewDatasoure")
        
        self.startController = startController
    }
    
    // MARK: - UITableViewDatasource 
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appDelegate.mpcManager.foundPeers.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = self.appDelegate.mpcManager.foundPeers[indexPath.row].displayName
        return cell
    }
}
