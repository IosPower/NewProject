//
//  ColorExtension.swift
//  Velocity Bom
//
//  Created by piyush sinroja on 18/01/19.
//  Copyright © 2019 Credencys. All rights reserved.
//

import UIKit

// MARK: - UIColor extension
extension UIColor {
    ///
    static var lightGreen: UIColor {
        return R.color.lightGreen() ?? UIColor(red: 178/255, green: 204/255, blue: 0/255, alpha: 1)
    }
    ///
    static var saffron: UIColor {
        return R.color.saffron() ?? UIColor(red: 228/255, green: 169/255, blue: 74/255, alpha: 1)
    }
    ///
    static var steelBlue: UIColor {
        return R.color.steelBlue() ?? UIColor(red: 0/255, green: 92/255, blue: 144/255, alpha: 1)
    }
    ///
    static var grayNew: UIColor {
        return R.color.grayNew() ?? UIColor(red: 121/255, green: 122/255, blue: 124/255, alpha: 1)
    }
    ///
    static var newsRecentMessagesBackgroundColor: UIColor {
        return UIColor(red: 242/255, green: 246/255, blue: 220/255, alpha: 1)
    }
    ///
    static var newsRecentMessagesCategoryBackgroundColor: UIColor {
        return UIColor(red: 227/255, green: 236/255, blue: 182/255, alpha: 1)
    }
    ///
    static var eventsRecentMessagesBackgroundColor: UIColor {
        return UIColor(red: 245/255, green: 222/255, blue: 188/255, alpha: 1)
    }
    ///
    static var eventRecentMessagesCategoryBackgroundColor: UIColor {
        return UIColor(red: 241/255, green: 206/255, blue: 152/255, alpha: 1)
    }
}
