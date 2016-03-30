//
//  SettingsTableViewDelegate.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 29.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit

class SettingsTableViewDelegate : NSObject, UITableViewDelegate {
    
    // MARK: - Properties
    
    var settingsController:SettingsController?
    let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    // MARK: - Initializer
    
    init(settingsController:SettingsController) {
        super.init()
        self.settingsController = settingsController
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 && self.userDefaults.boolForKey(AppConstants.UserDefaults.isBrowsingEnabled) == true {
            let headerView = UIView.loadFromNibNamed("UIViewLoadingHeader") as! UIViewLoadingHeader
            headerView.activityIndicator.startAnimating()
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.userDefaults.boolForKey(AppConstants.UserDefaults.isBrowsingEnabled) == true {
            return 35
        } else {
            return 0
        }
    }
}