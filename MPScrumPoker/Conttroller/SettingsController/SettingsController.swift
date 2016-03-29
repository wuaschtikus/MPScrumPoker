//
//  SettingsController.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 29.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import Foundation
import Bohr

class SettingsController : UITableViewController {
    
    // MARK: - Enum
    
    enum NotificationName : String {
        case ReloadTableView = "SettingsController.ReloadTableView"
    }
    
    // MARK: - Prtoperties
    
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
        self.tableView.registerNib(UINib(nibName: "UITableViewCellAdvertising",
            bundle: NSBundle(forClass: self.dynamicType)),
                                   forCellReuseIdentifier: "UITableViewCellAdvertising")
        self.tableView.registerNib(UINib(nibName: "UITableViewCellPeer",
            bundle: NSBundle(forClass: self.dynamicType)),
                                   forCellReuseIdentifier: "UITableViewCellPeer")
        
        
        
        self.settingsTableViewDelegate = SettingsTableViewDelegate(settingsController: self)
        self.settingsTableViewDatasource = SettingsTableViewDatasource(settingsController: self)
    }
    
    private func setupUserDefaults() {
        NSUserDefaults.standardUserDefaults().registerDefaults([
            "bool_1":true,
            "bool_2":false]
        )
    }
    
    // MARK: - Public 
    
    func reloadTableView() {
        self.settingsTableViewDatasource = SettingsTableViewDatasource(settingsController: self)
    }
}
