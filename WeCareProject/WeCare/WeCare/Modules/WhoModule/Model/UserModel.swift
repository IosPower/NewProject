//
//  UserViewModel.swift
//  WeCare
//
//  Created by Admin on 26/03/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import SwiftyJSON

class UserModel: NSObject {
    // MARK: - Variables
    
    ///
    var userId: Int = 0
    ///
    var email = ""
    ///
    var first_name = ""
    ///
    var last_name = ""
    ///
    var mobile = ""
    ///
    var language = ""
    ///
    var phone = ""
    ///
    var profile_image = ""
    ///
    var department_name = ""
    
    // MARK: - Initialize
    
    ///
    convenience init(json: JSON?) {
        self.init()
        guard let jsonResponse = json else {
            return
        }
        userId = jsonResponse["id"].intValue
        email = jsonResponse["email"].stringValue
        first_name = jsonResponse["first_name"].stringValue
        last_name = jsonResponse["last_name"].stringValue
        mobile = jsonResponse["mobile"].stringValue
        language = jsonResponse["language"].stringValue
        phone = jsonResponse["phone"].stringValue
        profile_image = jsonResponse["profile_image"].stringValue
        department_name = jsonResponse["department_name"].stringValue
    }
}
