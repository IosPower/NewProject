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
    
//    {
//        "id": 2,
//        "type": 2,
//        "title": "Dutch unite water, energy and food in Expo 2020 Dubai pavilion",
//        "short_description": "'We zijn trots op dit prachtige ontwerp, dat laat zien waar Nederland voor staat', zegt de Nederlandse minister van Buitenlandse Handel en Ontwikkeling Sigrid Kaag.",
//        "description": "<p>&#39;We zijn trots op dit prachtige ontwerp, dat laat zien waar Nederland voor staat&#39;, zegt de Nederlandse minister van Buitenlandse Handel en Ontwikkeling Sigrid Kaag. &lsquo;Unieke ge&iuml;ntegreerde oplossingen ontwikkelen die verbindingen cre&euml;ren, vooral op het gebied van water, energie en voedsel, waar we wereldleiders zijn.&rsquo;</p>\r\n\r\n<p>Het Midden-Oosten wordt sterk getroffen door mondiale problemen zoals waterschaarste, voedselzekerheid en stijgende vraag naar energie. Golfstaten verbruiken doorgaans meer water en energie per hoofd van de bevolking dan veel andere delen van de wereld, en het merendeel van het voedsel in de regio wordt ge&iuml;mporteerd. Expo 2020 Dubai biedt een geweldige kans <strong>om positieve verandering te stimuleren</strong>.</p>",
//        "address": "12 Stephenson Road",
//        "image": "",
//        "event_time": "02:15 am",
//        "event_start_date": "25 Mar, 2020",
//        "event_end_date": "18 Mar, 2020",
//        "sub_category_name": "Personeel",
//        "created_at": "17 Mar, 2020",
//        "category": "Personeel"
//    }
    
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
    }
}
