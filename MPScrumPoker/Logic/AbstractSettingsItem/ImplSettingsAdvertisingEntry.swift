//
//  ImplSettingsAdvertisingEntry.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 29.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit

class ImplSettingsAdvertisingEntry : SettingsEntryProtocol {
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    func createCell(settingsController:SettingsController, tableView:UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCellAdvertising") as! UITableViewCellAdvertising
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.shifter.removeTarget(settingsController, action: nil, forControlEvents: UIControlEvents.AllEvents)
        cell.shifter.addTarget(settingsController, action: #selector(SettingsController.toggleAdvertising(_:)), forControlEvents: UIControlEvents.ValueChanged)
        cell.shifter.on = userDefaults.boolForKey(AppConstants.UserDefaults.isBrowsingEnabled)
        return cell
    }
}