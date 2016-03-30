//
//  ImplSettingsBrowsingEntry.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 30.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit

class ImplSettingsBrowsingEntry: SettingsEntryProtocol {
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    func createCell(settingsController:SettingsController, tableView:UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCellAdvertising") as! UITableViewCellAdvertising
        cell.title.text = AppConstants.Settings.Browsing.description
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.shifter.addTarget(settingsController, action: #selector(SettingsController.toggleBrowsing(_:)), forControlEvents: UIControlEvents.ValueChanged)
        cell.shifter.on = userDefaults.boolForKey(AppConstants.UserDefaults.isBrowsingEnabled)
        return cell
    }
}