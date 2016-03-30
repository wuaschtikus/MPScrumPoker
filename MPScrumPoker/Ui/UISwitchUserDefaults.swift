//
//  UISwitchUserDefaults.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 30.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit
import CleanroomLogger

class UISwitchUserDefaults: UISwitch {
    
    var userDefaultKey:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepare(userDefaultKey:String) {
        self.userDefaultKey = userDefaultKey
        self.on = NSUserDefaults.standardUserDefaults().boolForKey(userDefaultKey)
    }
    
    override func setOn(on: Bool, animated: Bool) {
        super.setOn(on, animated: true)
        
        guard let actualKey = self.userDefaultKey else {
            Log.warning?.message("User Default key must not be nil")
            return
        }
        
        NSUserDefaults.standardUserDefaults().setBool(on, forKey: actualKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}