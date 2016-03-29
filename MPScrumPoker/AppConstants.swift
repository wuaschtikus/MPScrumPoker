//
//  Constants.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 29.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import Foundation

struct AppConstants {
    
    struct Multipeer {
        
        /// There are two rules that you should always follow when setting this value: (a) It mustn’t be longer than 15 characters, and (b) it can contain only lowercase ASCII characters, numbers and hyphens. In case you break any rule, an exception will be thrown at runtime and the app will crash.
        static let serviceType = "midorimultipeer"
        
        static let invitationTimeout = Double(20)
    }
    
    struct Alert {
        
        static let OkButtonTitle = NSLocalizedString("Ok", comment: "")
        static let NoButtonTitle = NSLocalizedString("No", comment: "")
        
        struct StartAdvertising {
            static let title = NSLocalizedString("Advertising", comment: "")
            static let msg = NSLocalizedString("Make me visisble to other devices?", comment: "")
        }
        
        struct StopAdvertising {
            static let title = NSLocalizedString("Advertising", comment: "")
            static let msg = NSLocalizedString("Make me invisible to other devices?", comment: "")
        }
        
        struct Invitation {
            static let title = NSLocalizedString("Invitation", comment: "")
            static let msg = NSLocalizedString("%@ wants to invite you.", comment: "")
        }
    }
}
