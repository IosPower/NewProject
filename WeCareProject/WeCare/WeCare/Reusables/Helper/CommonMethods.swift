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
    static func openSideMenu(sender: UIButton, vc: UIViewController) {
        sender.isUserInteractionEnabled = false
        guard let sideMenu = SideMenuManager.default.leftMenuNavigationController else { return }
        vc.present(sideMenu, animated: true, completion: {
            sender.isUserInteractionEnabled = true
        })
    }
    
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
