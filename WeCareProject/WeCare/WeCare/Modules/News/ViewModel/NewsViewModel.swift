
//
//  NewsViewModel.swift
//  WeCare
//
//  Created by Admin on 28/03/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import SwiftyJSON

class NewsViewModel: NSObject {
    
    private var apiPath = ""
    
    ///
    let perPageCount = 10
    ///
    var newsVC: NewsVC?
    ///
    var pageNo = 1
    ///
    var totalCount = 0
    ///
    var newsCategoryModelArray : [NewsCategoryModel] = []
    ///
    var newsRecentMessagesModelArray: [NewsDataModel] = []
    ///
    var newDataArray : [NewsDataModel] = []
    ///
    private var categoryKey = ""
    ///
    private var recentDataKey = ""
    ///
    var sideMenuSectionScreen: SideMenuSectionScreen? {
        didSet {
            guard let sideMenuSectionScreenObject = self.sideMenuSectionScreen else {return}
            switch sideMenuSectionScreenObject {
            case .news:
                categoryKey = "messageCategory"
                recentDataKey = "recentMessages"
                
                // set api path
                apiPath = ApiList.News.newsList
            case .event:
                categoryKey = "eventCategory"
                recentDataKey = "recentEvent"
                
               // set api path
                apiPath = ApiList.Event.eventList
            case .survey:
                recentDataKey = "surveyEvent"
                
               // set api path
                apiPath = ApiList.Survey.surveyList
            }
        }
    }
 
    init(vc: NewsVC) {
        super.init()
        newsCategoryModelArray = []
        newsRecentMessagesModelArray = []
        newDataArray = []
        newsVC = vc
    }
    
    // MARK: - API Call
    func newsListAPI(success: @escaping () -> Void, failure: @escaping (_ errorResponse: [String: Any]) -> Void) {
        
        let param = createParameter()
        
        ApiManager.sharedInstance.requestFor(urlPath: apiPath, param: param, httpMethod: .post, includeHeader: true, success: { [weak self] (response) in
            let jsonData = JSON(response)
            self?.totalCount = jsonData["total_count"].intValue
            if let status = jsonData[ModelKeys.ResponseKeys.status].int, status == 1 {
                DispatchQueue.main.async {
                    self?.parseResponse(jsonData: jsonData)
                    success()
                }
            } else {
                var errorMessage = Messages.somethingWrong
                if let message = jsonData[ModelKeys.ResponseKeys.message].string {
                    errorMessage = message
                }
                failure([ModelKeys.ResponseKeys.message: errorMessage])
            }
            }, failure: { (response, _) in
                failure(response)
        })
    }
    
    private func createParameter() -> [String: Any] {
        guard let sideMenuSectionScreenObject = self.sideMenuSectionScreen else {
            return [:]
        }
        if sideMenuSectionScreenObject == .survey {
            // no type parameter in survey
            return ["language": "nl", "page_no": pageNo, "user_id": 5]
        } else {
            return ["language": "nl", "page_no": pageNo, "user_id": 5, "type": 1]
        }
    }
    
    private func parseResponse(jsonData: JSON) {
        guard let sideMenuSectionScreenObject = self.sideMenuSectionScreen else {return}
        pageNo += 1
        let newsArray = jsonData[ModelKeys.ResponseKeys.data].arrayValue.map {NewsDataModel(json: $0)}
        newDataArray.append(contentsOf: newsArray)
   
        newsCategoryModelArray = jsonData[categoryKey].arrayValue.map {NewsCategoryModel(json: $0, sideMenuSectionScreen: sideMenuSectionScreenObject)}
        newsRecentMessagesModelArray = jsonData[recentDataKey].arrayValue.map {NewsDataModel(json: $0)}
    }
    
    func sectionHeaderArray() -> [String] {
        switch self.sideMenuSectionScreen {
        case .news:
            return ["VERS VAN DE PERS", "ALLE BERICHTEN"]
        case .event:
            return ["COMING UP...", "ALL EVENTS"]
        case .survey:
            return ["JOUW MENING IS BELANGRIJK", "DANK VOOR JOUW MEDEWERKING!"]
        case .none:
            return []
        }
    }
}
