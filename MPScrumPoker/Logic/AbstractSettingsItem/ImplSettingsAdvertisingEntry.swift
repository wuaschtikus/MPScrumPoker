//
//  ImplSettingsAdvertisingEntry.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 29.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit

class ImplSettingsAdvertisingEntry : SettingsEntryProtocol {
    
    func createCell(tableView:UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCellAdvertising") as! UITableViewCellAdvertising
        
        return cell
    }
}