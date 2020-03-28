//
//  LoginVC.swift
//  WeCare
//
//  Created by Dinesh on 14/03/2020.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    //
    @IBOutlet weak var titleLbl: UILabel!
    //
    @IBOutlet weak var subtitleLbl: UILabel!
    //
    @IBOutlet weak var emailTxtField: UITextField!
    //
    @IBOutlet weak var passwordTxtField: UITextField!
    //
    @IBOutlet weak var loginBTN: UIButton!
    //
    @IBOutlet weak var forgotPasswordBTN: UIButton!
    
    @IBOutlet weak var haventAcountLbl: UILabel!
    
    @IBOutlet weak var signUpBTN: UIButton!
    
    // MARK: - Variables
    
    ///
    private var activeTextfield: UITextField?
    
    ///
    private var loginViewModel: LoginViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel = LoginViewModel()
        hideNavigationBar()
    }
    
    //
    @IBAction func loginBtnAction(_ sender: Any) {
        
        emailTxtField.text = "fdfgd@gmail.com"
        passwordTxtField.text = "fdgdgd"
        
        loginViewModel?.validation(emaiId: emailTxtField.text, password: passwordTxtField.text, completion: { [weak self] (isValid, message) in
            guard isValid else {
                self?.showAlert(message: message, buttonTitle: Messages.Button.okButton, completion: {
                    self?.activeTextfield?.becomeFirstResponder()
                })
                return
            }
            self?.view.endEditing(true)
            self?.loginAPICall()
        })
    }
    
    ///
    func navigateToDashboardVC() {
        // check login validation and call login api
        if let dashboardVC = R.storyboard.dashboard.dashboardVC() {
            self.push(viewController: dashboardVC)
        }
    }
    
    //
    @IBAction func forgotPasswordBtnAction(_ sender: Any) {
        
    }
    
    //
    @IBAction func signUpBtnAction(_ sender: Any) {
        
    }
    
    // MARK: - API Methods
    
    /// callApi for login
    func loginAPICall() {
        let parameters = ["email": "kris.michiels@vaillant.com",
                          "password": "123456"]
//        self.navigateToDashboardVC()
        loginViewModel?.loginApi(parameters: parameters, success: { [weak self] in
            self?.navigateToDashboardVC()
            }, failure: { [weak self] (responseDict) in
                if let message = responseDict[ModelKeys.ResponseKeys.message] as? String {
                    self?.showAlert(message: message, buttonTitle: Messages.Button.okButton)
                }
        })
    }
}
