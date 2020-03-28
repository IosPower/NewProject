
//
//  NewsViewModel.swift
//  WeCare
//
//  Created by Admin on 28/03/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import SwiftyJSON

class NewsViewModel: NSObject {
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
    init(vc: NewsVC) {
        super.init()
        newsCategoryModelArray = []
        newsRecentMessagesModelArray = []
        newDataArray = []
        newsVC = vc
    }
    
    // MARK: - API Call
    func newsListAPI(success: @escaping () -> Void, failure: @escaping (_ errorResponse: [String: Any]) -> Void) {
        
        let param: [String: Any]  = ["language": "nl", "page_no": pageNo, "user_id": 5, "type": 1]
        
        ApiManager.sharedInstance.requestFor(urlPath: ApiList.News.newsList, param: param, httpMethod: .post, includeHeader: true, success: { [weak self] (response) in
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
    
    func parseResponse(jsonData: JSON) {
        pageNo += 1
        let newsArray = jsonData[ModelKeys.ResponseKeys.data].arrayValue.map {NewsDataModel(json: $0)}
        newDataArray.append(contentsOf: newsArray)
        
        newsCategoryModelArray = jsonData["messageCategory"].arrayValue.map {NewsCategoryModel(json: $0)}
        newsRecentMessagesModelArray = jsonData["recentMessages"].arrayValue.map {NewsDataModel(json: $0)}
    }
}
