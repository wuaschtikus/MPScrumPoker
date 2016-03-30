//
//  ImplSettingsEntryNoDevices.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 30.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import Foundation

import UIKit
import MultipeerConnectivity

class ImplSettingsNoDevices : SettingsEntryProtocol {
    
    func createCell(settingsController:SettingsController, tableView:UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCellNoDevices") as! UITableViewCellNoDevices
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
}