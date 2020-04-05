//
//  SideMenuViewModel.swift
//  WeCare
//
//  Created by Admin on 05/04/20.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import SwiftyJSON

class SideMenuViewModel: NSObject {
  
    ///
    var newsCategoryModelArray : [CategoryModel] = []
    ///
    var eventCategoryModelArray : [CategoryModel] = []
  
    ///
    var sideMenuModelArray: [SideMenuModel] = []
    
    override init() {
        super.init()
        newsCategoryModelArray = []
        eventCategoryModelArray = []
        
        let newsSideMenuModel = SideMenuModel(keyName: "BERICHTEN", keyData: [], imgName: "icn_menu_news", color: UIColor.lightGreen, isExpand: false)
        let eventSideMenuModel = SideMenuModel(keyName: "EVENTS", keyData: [], imgName: "icn_menu_event", color: UIColor.saffron, isExpand: false)
        let surveySideMenuModel = SideMenuModel(keyName: "ENQUÊTE", keyData: [], imgName: "icn_menu_inquiries", color: UIColor.steelBlue, isExpand: false)
        let userSideMenuModel = SideMenuModel(keyName: "WIE IS WIE", keyData: [], imgName: "icn_menu_whoiswho", color: UIColor.grayNew, isExpand: false)

        sideMenuModelArray = [newsSideMenuModel, eventSideMenuModel, surveySideMenuModel, userSideMenuModel]
    }
    
//    var mainDataArray = [[
//           "keyName": "BERICHTEN",
//           "keyData": [
//               ["titleName": "TAKING CARE",
//                "color": UIColor(displayP3Red: 189/255, green: 207/255, blue: 89/255, alpha: 1.0)],
//               ["titleName": "VAILLANT GROUP",
//                "color": UIColor(displayP3Red: 223/255, green: 232/255, blue: 177/255, alpha: 1.0)]
//           ],
//           "imgName": "icn_menu_news",
//           "color": UIColor.lightGreen,
//           "isExpand": false
//           ], [
//               "keyName": "EVENTS",
//               "keyData": [
//                   ["titleName": "KLANTEN",
//                    "color": UIColor(displayP3Red: 231/255, green: 178/255, blue: 108/255, alpha: 1.0)],
//                   ["titleName": "PERSONEEL",
//                    "color": UIColor(displayP3Red: 238/255, green: 198/255, blue: 145/255, alpha: 1.0)]
//               ],
//               "imgName": "icn_menu_event",
//               "color" : UIColor.saffron,
//               "isExpand": false
//           ], [
//               "keyName": "ENQUÊTE",
//               "keyData": [],
//               "imgName": "icn_menu_inquiries",
//               "color" : UIColor.steelBlue,
//               "isExpand": false
//           ], [
//               "keyName": "WIE IS WIE",
//               "keyData": [],
//               "imgName": "icn_menu_whoiswho",
//               "color" : UIColor.grayNew,
//               "isExpand": false
//           ]]
    
    // MARK: - API Call
    func newsCategoryListAPI(success: @escaping () -> Void, failure: @escaping (_ errorResponse: [String: Any]) -> Void) {
        
        let param = createParameter()
        
        ApiManager.sharedInstance.requestFor(urlPath: ApiList.News.newsCategory, param: param, httpMethod: .post, includeHeader: true, success: { [weak self] (response) in
            let jsonData = JSON(response)
            if let status = jsonData[ModelKeys.ResponseKeys.status].int, status == 1 {
                DispatchQueue.main.async {
                    
                    self?.newsCategoryModelArray = jsonData["messageCategory"].arrayValue.map {CategoryModel(json: $0, sideMenuSectionScreen: SideMenuSectionScreen.news)}

                    self?.sideMenuModelArray[0].keyData = self?.newsCategoryModelArray ?? []
                    
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
    
    // MARK: - API Call
    func eventCategoryListAPI(success: @escaping () -> Void, failure: @escaping (_ errorResponse: [String: Any]) -> Void) {
        
        let param = createParameter()
        
        ApiManager.sharedInstance.requestFor(urlPath: ApiList.Event.eventCategory, param: param, httpMethod: .post, includeHeader: true, success: { [weak self] (response) in
            let jsonData = JSON(response)
            if let status = jsonData[ModelKeys.ResponseKeys.status].int, status == 1 {
                DispatchQueue.main.async {
                    self?.eventCategoryModelArray = jsonData["eventCategory"].arrayValue.map {CategoryModel(json: $0, sideMenuSectionScreen: SideMenuSectionScreen.event)}
                    
                    self?.sideMenuModelArray[1].keyData = self?.eventCategoryModelArray ?? []
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
        return ["language": "nl", "user_id": 5]
    }
}
