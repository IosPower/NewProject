//
//  LoginViewModel.swift
//  WeCare
//
//  Created by Dinesh on 14/03/2020.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginViewModel {
    
    // MARK: - Variables
    
    ///
    func loginApi(parameters: [String: Any], success: @escaping () -> Void, failure: @escaping ([String: Any]) -> Void) {
        // get api sample
        
        ApiManager.sharedInstance.requestFor(urlPath: ApiList.UserManagement.login, param: parameters, httpMethod: .post, includeHeader: true, success: { (response) in
            print(response)
            let jsonData = JSON(response)
            
            if let isSuccess = jsonData[ModelKeys.ResponseKeys.status].int, isSuccess == 1 {
                DispatchQueue.main.async {
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
    
    // MARK: - Validation Login
    
    ///
    /// Validation for login
    ///
    /// - Parameter completion: completion return with bool and message string
    func validation(emaiId: String?, password: String?, completion: @escaping (Bool, String) -> Void) {
        let emailValue = emaiId ?? ""
        let passwordValue = password ?? ""
        if emailValue.isEmpty && passwordValue.removeWhiteSpace().isEmpty {
            completion(false, Messages.LoginScreen.strEmailAndPassValidMsg)
        } else if emailValue.removeWhiteSpace().isEmpty {
            completion (false, Messages.LoginScreen.strEmailIdMsg)
        } else if emailValue.isValidEmail() == false {
            completion (false, Messages.LoginScreen.strValidEmailIdMsg)
        } else if passwordValue.removeWhiteSpace().isEmpty {
            completion (false, Messages.LoginScreen.strpasswordMsg)
        } else {
            completion (true, "")
        }
    }
}
