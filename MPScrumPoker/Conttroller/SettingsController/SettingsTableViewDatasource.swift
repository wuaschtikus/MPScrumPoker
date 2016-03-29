//
//  SettingsTableViewDatasource.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 29.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit

class SettingsTableViewDatasource: NSObject, UITableViewDataSource {
    
    // MARK: - Properties
    
    var settingsController:SettingsController?
    var datasource:[String:[Abstract]]
    
    // MARK: - Initializer
    
    init(settingsController:SettingsController) {
        super.init()
        self.settingsController = settingsController
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
}