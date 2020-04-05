
//
//  NewsViewModel.swift
//  WeCare
//
//  Created by Admin on 28/03/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import SwiftyJSON

class NewsEventSurveyViewModel: NSObject {
    
    private var apiPath = ""
    
    ///
    let perPageCount = 10
    ///
    var newsEventSurveyVC: NewsEventSurveyVC?
    ///
    var pageNo = 1
    ///
    var totalCount = 0
    ///
    var categoryModelArray : [CategoryModel] = []
    ///
    var newsEventSurveyRecentDataModelArray: [DataModel] = []
    ///
    var newsEventSurveyDataArray : [DataModel] = []
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
 
    init(vc: NewsEventSurveyVC) {
        super.init()
        categoryModelArray = []
        newsEventSurveyRecentDataModelArray = []
        newsEventSurveyDataArray = []
        newsEventSurveyVC = vc
    }
    
    // MARK: - API Call
    func newsListAPI(type: Int, isResetData: Bool, success: @escaping () -> Void, failure: @escaping (_ errorResponse: [String: Any]) -> Void) {
        if isResetData {
            newsEventSurveyRecentDataModelArray = []
            newsEventSurveyDataArray = []
            pageNo = 1
        }
        
        let param = createParameter(type: type)
        
        ApiManager.sharedInstance.requestFor(urlPath: apiPath, param: param, httpMethod: .post, includeHeader: true, success: { [weak self] (response) in
            let jsonData = JSON(response)
            self?.totalCount = jsonData["total_count"].intValue
            if let status = jsonData[ModelKeys.ResponseKeys.status].int, status == 1 {
                DispatchQueue.main.async {
                    self?.parseResponse(jsonData: jsonData, isResetData: isResetData)
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
    
    private func createParameter(type: Int) -> [String: Any] {
        guard let sideMenuSectionScreenObject = self.sideMenuSectionScreen else {
            return [:]
        }
        if sideMenuSectionScreenObject == .survey {
            // no type parameter in survey
            return ["language": "nl", "page_no": pageNo, "user_id": 5]
        } else {
            return ["language": "nl", "page_no": pageNo, "user_id": 5, "type": type]
        }
    }
    
    private func parseResponse(jsonData: JSON, isResetData: Bool) {
        guard let sideMenuSectionScreenObject = self.sideMenuSectionScreen else {return}
        let newsArray = jsonData[ModelKeys.ResponseKeys.data].arrayValue.map {DataModel(json: $0)}
        let recentArray = jsonData[recentDataKey].arrayValue.map {DataModel(json: $0)}
        if newsArray.count > 0 {
            pageNo += 1
            newsEventSurveyDataArray.append(contentsOf: newsArray)
        }
        newsEventSurveyRecentDataModelArray = recentArray
        if isResetData == false {
            categoryModelArray = jsonData[categoryKey].arrayValue.map {CategoryModel(json: $0, sideMenuSectionScreen: sideMenuSectionScreenObject)}
        }
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
