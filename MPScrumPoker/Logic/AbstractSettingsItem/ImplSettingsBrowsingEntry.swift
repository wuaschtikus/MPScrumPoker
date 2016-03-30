//
//  ImplSettingsBrowsingEntry.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 30.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit

class ImplSettingsBrowsingEntry: SettingsEntryProtocol {
    
    func createCell(tableView:UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCellAdvertising") as! UITableViewCellAdvertising
        cell.title.text = AppConstants.Settings.Browsing.description
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
}