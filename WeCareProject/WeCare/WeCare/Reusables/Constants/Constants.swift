//
//  Constants.swift
//  WeCare
//
//  Created by Dinesh on 13/03/2020.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    // MARK: - AppDel Shared Object
    ///
    static var AppDel = UIApplication.shared.delegate as! AppDelegate
    ///
    static var navigationController: UINavigationController?
    
    ///
    static let defulatLanguageSelection = "en"
    ///
    static var MAINWINDOW = UIApplication.shared.windows
    
    ///
    static let window = Constants.AppDel.window
    
    // MARK: - iPhone size
    ///
    static let isiPhone5: Bool = 568 == UIScreen.main.bounds.size.height ? true : false
    ///
    static let isiPhone6: Bool = 667 == UIScreen.main.bounds.size.height ? true : false
    ///
    static let isiPhone6Plus: Bool = 736 == UIScreen.main.bounds.size.height ? true : false
    ///
    static let isiPhoneX: Bool = 812 == UIScreen.main.bounds.size.height ? true : false
    ///
    static let isiPhoneXR: Bool = 896 == UIScreen.main.bounds.size.height ? true : false
   
    
}
