
//
//  DashboardViewModel.swift
//  WeCare
//
//  Created by Admin on 29/03/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import SwiftyJSON

class DashboardViewModel: NSObject {
    
    private var apiPath = ""
    
    ///
    let perPageCount = 10
    ///
    var dashboardVc: DashboardVC?
    ///
    var pageNo = 1
    ///
    var totalCount = 0
    ///
    var dashboardDataModelArray : [DashboardDataModel] = []
    ///
    var message_unread_count = 0
    ///
    var event_unread_count = 0
    ///
    var survey_unread_count = 0
    
    init(vc: DashboardVC) {
        super.init()
        
        dashboardDataModelArray = []
        dashboardVc = vc
    }
    
    // MARK: - API Call
    func dashboardListAPI(success: @escaping () -> Void, failure: @escaping (_ errorResponse: [String: Any]) -> Void) {
        
        let param = createParameter()
        
        ApiManager.sharedInstance.requestFor(urlPath: ApiList.Dashboard.dashboardList, param: param, httpMethod: .post, includeHeader: true, success: { [weak self] (response) in
            let jsonData = JSON(response)
            self?.totalCount = jsonData["total_count"].intValue
            self?.message_unread_count = jsonData["message_unread_count"].intValue
            self?.event_unread_count = jsonData["event_unread_count"].intValue
            self?.survey_unread_count = jsonData["survey_unread_count"].intValue
          
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
        return ["language": "nl", "page_no": pageNo, "user_id": 11]
    }
    
    private func parseResponse(jsonData: JSON) {
        pageNo += 1
        let newsArray = jsonData[ModelKeys.ResponseKeys.data].arrayValue.map {DashboardDataModel(json: $0)}
        dashboardDataModelArray.append(contentsOf: newsArray)
    }
}
