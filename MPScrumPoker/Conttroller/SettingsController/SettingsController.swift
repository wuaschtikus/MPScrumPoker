//
//  SettingsController.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 29.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import Foundation
import Bohr

class SettingsController : BOTableViewController {
    
    // MARK: - Prtoperties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setup() {
        self.setupUserDefaults()
        self.addSection(BOTableViewSection(headerTitle: AppConstants.Settings.Advertising.sectionTitle, handler: { (section) in
            section.addCell(BOSwitchTableViewCell(title: AppConstants.Settings.Advertising.description, key: "bool_1", handler: nil))
        }))
    }
    
    // MARK: - Private 
    
    private func setupUserDefaults() {
        NSUserDefaults.standardUserDefaults().registerDefaults([
            "bool_1":true,
            "bool_2":false]
        )
    }
    
    private func setupAppearance() {
        
    }
}
