//
//  AbstractSettingsEntry.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 29.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit

enum SettingsEntry {
    case Advertising
    case Peer
}

protocol SettingsEntryProtocol {
    func createCell(tableView:UITableView, indexPath: NSIndexPath) -> UITableViewCell
}

class SettingsEntryFactory {
//    class func factoryFor(settingsEntry:SettingsEntry) -> SettingsEntryProtocol {
//        
//        switch settingsEntry {
//            
//        case SettingsEntry.Advertising:
//            return ImplSettingsAdvertisingEntry()
//            
//        case SettingsEntry.Peer:
//            return ImplSettingsPeerEntry()
//        }
//    }
}
