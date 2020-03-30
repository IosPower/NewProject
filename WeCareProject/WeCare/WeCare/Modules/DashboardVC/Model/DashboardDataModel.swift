//
//  DashboardDataModel.swift
//  WeCare
//
//  Created by Admin on 29/03/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import SwiftyJSON

class DashboardDataModel: NSObject {
    
    var id = 0
    var tra_id = 0
    var title = ""
    var is_read = 0
    var created_at = ""
    var short_description = ""
    var image = ""
    var type = 0

    // MARK: - Initialize
    
    ///
    convenience init(json: JSON?) {
        self.init()
        guard let jsonResponse = json else {
            return
        }
        id = jsonResponse["id"].intValue
        tra_id = jsonResponse["tra_id"].intValue
        title = jsonResponse["title"].stringValue
        is_read = jsonResponse["is_read"].intValue
        created_at = jsonResponse["created_at"].stringValue
        short_description = jsonResponse["short_description"].stringValue
        image = jsonResponse["image"].stringValue
        type = jsonResponse["type"].intValue
    }
}
