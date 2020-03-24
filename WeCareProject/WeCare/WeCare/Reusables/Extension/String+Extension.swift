//
//  Extension.swift
//  Hochiki
//
//  Created by piyush sinroja on 13/03/18.
//  Copyright © 2018 Credencys. All rights reserved.
//

import UIKit
// MARK: - Extension for String Methods
///
extension String {
    /// Trim string from left & right side extra spaces.
    ///
    /// - Returns: final string after removing extra left & right space.
    
    ///
    func removeWhiteSpace() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    // check valid mail
    func isValidEmail() -> Bool {
        if self.isEmpty {
            return false
        }
        let emailRegEx = "[.0-9a-zA-Z_-]+@[0-9a-zA-Z.-]+\\.[a-zA-Z]{2,20}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if !emailTest.evaluate(with: self) {
            return false
        }
        return true
    }
    
    // check valid Password
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$£€§%…^&*\\/()\\[\\]\\-_=+{}|?>.<,:;~`'\"/\\\\]{8,128}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}
