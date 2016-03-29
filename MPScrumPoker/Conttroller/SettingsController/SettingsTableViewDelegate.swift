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
    
    // MARK: - Initializer
    
    init(settingsController:SettingsController) {
        super.init()
        self.settingsController = settingsController
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = UIView.loadFromNibNamed("UIViewLoadingHeader") as! UIViewLoadingHeader
            headerView.activityIndicator.startAnimating()
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
}