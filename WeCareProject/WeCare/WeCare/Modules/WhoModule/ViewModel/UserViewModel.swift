//
//  UserViewModel.swift
//  WeCare
//
//  Created by Admin on 27/03/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import SwiftyJSON

class UserViewModel: NSObject {

    // MARK: - Variables
    
    ///
    var totalCount = 0
    ///
    let perPageCount = 10
    ///
    var userModelArray = [UserModel]()
    ///
    var userVC: UserVC?
    ///
    var pageNo = 1
    ///
    init(vc: UserVC) {
        super.init()
        userModelArray = []
        userVC = vc
    }
    
    // MARK: - API Call
    
    func userListAPI(success: @escaping () -> Void, failure: @escaping (_ errorResponse: [String: Any]) -> Void) {
        
        let param: [String: Any]  = ["language": "nl", "page_no": pageNo, "user_id": "2", "search": ""]
        
        ApiManager.sharedInstance.requestFor(urlPath: ApiList.UserManagement.userList, param: param, httpMethod: .post, includeHeader: true, success: { [weak self] (response) in
            let jsonData = JSON(response)
            self?.totalCount = jsonData["total_count"].intValue
            if let status = jsonData[ModelKeys.ResponseKeys.status].int, status == 1 {
                DispatchQueue.main.async {
                    guard let array = jsonData[ModelKeys.ResponseKeys.data].array, array.count > 0 else {
                        self?.userModelArray = []
                        success()
                        return
                    }
                    self?.parseResponse(array: array, jsonData: jsonData)
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
    
    func parseResponse(array: [JSON], jsonData: JSON) {
       pageNo += 1
       let userArray = array.map {UserModel(json: $0)}
       userModelArray.append(contentsOf: userArray)
    }
    
}
