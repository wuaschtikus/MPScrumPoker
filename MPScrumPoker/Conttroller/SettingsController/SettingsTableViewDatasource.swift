//
//  SettingsTableViewDatasource.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 29.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit

class SettingsTableViewDatasource: NSObject, UITableViewDataSource {
    
    // MARK: - Properties
    
    var settingsController:SettingsController?
    
    var rows:[[SettingsEntryProtocol]]!
    var sections:[String] = [
        AppConstants.Settings.Advertising.sectionTitle,
        AppConstants.Settings.Peers.sectionTitle
    ]
    
    // MARK: - Initializer
    
    init(settingsController:SettingsController) {
        super.init()
        self.settingsController = settingsController
        
        self.prepareDatasource()
    }
    
    func prepareDatasource() {
        var section1:[SettingsEntryProtocol] = []
        var section2:[SettingsEntryProtocol] = []
        var datasourceTmp:[[SettingsEntryProtocol]] = []
        
        section1.append(ImplSettingsAdvertisingEntry())
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let peers = appDelegate.mpcManager.foundPeers
        
        for peer in peers {
            section2.append(ImplSettingsPeerEntry(peerId: peer))
        }
        
        datasourceTmp.append(section1)
        datasourceTmp.append(section2)
        
        self.rows = datasourceTmp
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rows[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = self.rows[indexPath.section][indexPath.row]
        let cell = row.createCell(tableView, indexPath: indexPath)
        
        return cell
    }
}