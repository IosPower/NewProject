import SwiftyJSON

class NewsCategoryModel: NSObject {
    var id = 0
    var message_category_name = ""
    var newsSubCategoryModelArray: [NewsSubCategoryModel] = []
    
    // MARK: - Initialize
   
    ///
    convenience init(json: JSON?) {
        self.init()
        guard let jsonResponse = json else {
            return
        }
        id = jsonResponse["id"].intValue
        message_category_name = jsonResponse["message_category_name"].stringValue
        newsSubCategoryModelArray = jsonResponse["sub_category"].arrayValue.map({NewsSubCategoryModel(json: $0)})
        
    }
}

class NewsSubCategoryModel: NSObject {
    
    var id = 0
    var message_category_name = ""
   
    // MARK: - Initialize
   
    ///
    convenience init(json: JSON?) {
        self.init()
        guard let jsonResponse = json else {
            return
        }
        id = jsonResponse["id"].intValue
        message_category_name = jsonResponse["message_category_name"].stringValue
    }
}
