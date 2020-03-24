//
//  AppDelegate.swift
//
//
//  Created by Pramit on 20/02/20.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /// The window for this application
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        appLaunchSetup()
        
        // Set rootViewController
        loadInitialScreen()
        
        return true
    }
    
    // MARK: - Custome methiods
    
    /// setup when the app is launching
    func appLaunchSetup() {
        
        // ApiManager initialize
        _ = ApiManager.sharedInstance
        
        // build environment set
        ApiConfiguration.sharedInstance.buildEnvironment = .development
        
        
        setupIQKeyboard()
    }
    
    /// Configure IQKeyboard
    func setupIQKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
}

// MARK: - Implement AppDelegate extension
extension AppDelegate {
    // MARK: Implement AppDelegate extension methods
    ///
    func loadInitialScreen() {
        guard let loginVC = R.storyboard.login.loginVC() else { return }
        loginVC.setAsRootController(in: window)
    }
}
