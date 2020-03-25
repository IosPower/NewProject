//
//  CommonMethods.swift
//  Driver
//
//  Created by RoH!T M!ShRa on 25/04/19.
//

import UIKit
import SideMenu

///
struct  CommonMethods {
    /// Manage Side Menu
    ///
    /// - Parameters:
    ///   - sender: UIButton refrence
    ///   - vc: Refrence of UIViewController
    static func openSideMenu(sender: UIButton, vc: UIViewController, sideMenuStatusBarColor: UIColor = .white) {
        sender.isUserInteractionEnabled = false
        guard let sideMenu = SideMenuManager.default.leftMenuNavigationController, let sideMenuVC = sideMenu.viewControllers[0] as? SideMenuVC else { return }
        sideMenuVC.statusBarColor = sideMenuStatusBarColor
        vc.present(sideMenu, animated: true, completion: {
            sender.isUserInteractionEnabled = true
        })
    }
    
//    static func closeSideMenu() {
//        guard let sideMenu = SideMenuManager.default.leftMenuNavigationController else { return }
//        sideMenu.dismiss(animated: true, completion: nil)
//    }
    
    /// Generating random string
    ///
    /// - Parameter length: string length
    /// - Returns: Give random string
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        // Hemant Change
        return String((0...length-1).map { _ in letters.randomElement() ?? Character("random") })
    }
    
}
