import SwiftyJSON

class NewsDataModel: NSObject {
    
    var id = 0
    var type = 0
    var title = ""
    var short_description = ""
    var descriptionValue = ""
    var image = ""
    var url = ""
    var priority = ""
    var sub_category_name = ""
    var created_at = ""
    var category = ""
    var youtube_thumbnail = ""
    
    // extra for events
    var address = ""
    var event_time = ""
    var event_start_date = ""
    var event_end_date = ""
  
    // extra for survey
    var is_fill = false
   
    // MARK: - Initialize
    
    ///
    convenience init(json: JSON?) {
        self.init()
        guard let jsonResponse = json else {
            return
        }
        id = jsonResponse["id"].intValue
        type = jsonResponse["type"].intValue
        title = jsonResponse["title"].stringValue
        short_description = jsonResponse["short_description"].stringValue
        descriptionValue = jsonResponse["descriptionValue"].stringValue
        image = jsonResponse["image"].stringValue
        url = jsonResponse["url"].stringValue
        priority = jsonResponse["priority"].stringValue
        sub_category_name = jsonResponse["sub_category_name"].stringValue
        created_at = jsonResponse["created_at"].stringValue
        category = jsonResponse["category"].stringValue
        youtube_thumbnail = jsonResponse["youtube_thumbnail"].stringValue
        
        // extra for events
        address = jsonResponse["address"].stringValue
        event_time = jsonResponse["event_time"].stringValue
        event_start_date = jsonResponse["event_start_date"].stringValue
        event_end_date = jsonResponse["event_end_date"].stringValue
        
        // extra for events
        is_fill = jsonResponse["is_fill"].boolValue
    }
}
