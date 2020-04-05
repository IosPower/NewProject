import SwiftyJSON

class NewsCategoryModel: NSObject {
    var id = 0
    var message_category_name = ""
    var newsSubCategoryModelArray: [NewsSubCategoryModel] = []
    var isExpand = false
    // MARK: - Initialize
   
    ///
    convenience init(json: JSON?, sideMenuSectionScreen: SideMenuSectionScreen) {
        self.init()
        guard let jsonResponse = json else {
            return
        }
        id = jsonResponse["id"].intValue
        message_category_name = getCategoryName(jsonResponse: jsonResponse, sideMenuSectionScreen: sideMenuSectionScreen)
        newsSubCategoryModelArray = jsonResponse["sub_category"].arrayValue.map({NewsSubCategoryModel(json: $0, sideMenuSectionScreen: sideMenuSectionScreen)})
    }
}

class NewsSubCategoryModel: NSObject {
    
    var id = 0
    var message_category_name = ""
   
    // MARK: - Initialize
   
    ///
    convenience init(json: JSON?, sideMenuSectionScreen: SideMenuSectionScreen) {
        self.init()
        guard let jsonResponse = json else {
            return
        }
        id = jsonResponse["id"].intValue
        message_category_name = getCategoryName(jsonResponse: jsonResponse, sideMenuSectionScreen: sideMenuSectionScreen)
    }
}

fileprivate func getCategoryName(jsonResponse: JSON, sideMenuSectionScreen: SideMenuSectionScreen) -> String {
    var message_category_name = ""
    switch sideMenuSectionScreen {
    case .news:
        message_category_name = jsonResponse["message_category_name"].stringValue
    case .event:
        message_category_name = jsonResponse["event_category_name"].stringValue
    case .survey:
        break
    }
    return message_category_name
}
