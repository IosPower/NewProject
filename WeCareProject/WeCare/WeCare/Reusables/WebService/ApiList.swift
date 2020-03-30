//
//  ApiList.swift
//  WeCare
//
//  Created by Dinesh on 16/03/2020.
//  Copyright © 2020 Piyush. All rights reserved.
//

import UIKit

/// This struct contains all Api list
struct ApiList {
    ///
    struct UserManagement {
        ///
        static let login = "user-login"
        ///
        static let userList = "user-list"
    }
    
    ///
    struct News {
        ///
        static let newsList = "messages-list"
        
    }
    ///
    struct Event {
        ///
        static let eventList = "event-list"
        
    }
    ///
    struct Survey {
        ///
        static let surveyList = "survey-list"
        
    }
    ///
    struct Dashboard {
        ///
        static let dashboardList = "dashboard-list"
        
    }
}
