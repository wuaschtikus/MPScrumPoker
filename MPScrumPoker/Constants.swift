//
//  Constants.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 29.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Multipeer {
        
        /// There are two rules that you should always follow when setting this value: (a) It mustn’t be longer than 15 characters, and (b) it can contain only lowercase ASCII characters, numbers and hyphens. In case you break any rule, an exception will be thrown at runtime and the app will crash.
        static let serviceType = "com.midori.MPScrumPoker"
    }
}
