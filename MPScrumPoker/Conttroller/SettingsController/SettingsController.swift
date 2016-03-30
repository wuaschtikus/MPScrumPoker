//
//  SettingsController.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 29.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit
import CleanroomLogger

class SettingsController : UITableViewController {
    
    // MARK: - Enum
    
    enum NotificationName : String {
        case ReloadTableView = "SettingsController.ReloadTableView"
    }
    
    // MARK: - Properties
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var settingsTableViewDatasource: SettingsTableViewDatasource? {
        willSet {
            self.tableView.dataSource = newValue
            self.tableView.reloadData()
        }
    }
    
    var settingsTableViewDelegate: SettingsTableViewDelegate? {
        willSet {
            self.tableView.delegate = newValue
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareTableView()
        self.prepareObserver()
    }
    
    // MARK: - Private
    
    private func prepareObserver() {
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(SettingsController.reloadTableView),
            name: SettingsController.NotificationName.ReloadTableView.rawValue,
            object: nil)
    }
    
    private func prepareTableView() {
        let bundle = NSBundle(forClass: self.dynamicType)

        self.tableView.registerNib(
            UINib(nibName: "UITableViewCellAdvertising", bundle: bundle),
            forCellReuseIdentifier: "UITableViewCellAdvertising")
        
        self.tableView.registerNib(
            UINib(nibName: "UITableViewCellPeer", bundle: bundle),
            forCellReuseIdentifier: "UITableViewCellPeer")
        
        self.tableView.registerNib(
            UINib(nibName: "UITableViewCellNoDevices", bundle: bundle),
            forCellReuseIdentifier: "UITableViewCellNoDevices")
        
        self.settingsTableViewDelegate = SettingsTableViewDelegate(settingsController: self)
        self.settingsTableViewDatasource = SettingsTableViewDatasource(settingsController: self)
    }
    
    // MARK: - Public
    
    func reloadTableView() {
        self.settingsTableViewDatasource = SettingsTableViewDatasource(settingsController: self)
    }
    
    func toggleBrowsing(sender:UISwitch) {
        
        let isBrowsingOn = NSUserDefaults.standardUserDefaults().boolForKey(AppConstants.UserDefaults.isBrowsingEnabled)
        
        NSUserDefaults.standardUserDefaults().setBool(
            sender.on,
            forKey: AppConstants.UserDefaults.isBrowsingEnabled)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        if isBrowsingOn {
            self.appDelegate.mpcManager.browser.stopBrowsingForPeers()
        } else {
            self.appDelegate.mpcManager.browser.startBrowsingForPeers()
        }
        
        self.tableView.reloadSections(
            NSIndexSet(index: 1),
            withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    func toggleAdvertising(sender:UISwitch) {
        
        let isAdvertisingOn = NSUserDefaults.standardUserDefaults().boolForKey(AppConstants.UserDefaults.isAdvertisingEnabled)
        
        NSUserDefaults.standardUserDefaults().setBool(
            sender.on,
            forKey: AppConstants.UserDefaults.isAdvertisingEnabled)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        if isAdvertisingOn {
            self.appDelegate.mpcManager.advertiser.stopAdvertisingPeer()
        } else {
            self.appDelegate.mpcManager.advertiser.startAdvertisingPeer()
        }
    }
    
    func disableAdvertising() {
        self.appDelegate.mpcManager.advertiser.stopAdvertisingPeer()
        self.appDelegate.isAdvertising = false
    }
}
