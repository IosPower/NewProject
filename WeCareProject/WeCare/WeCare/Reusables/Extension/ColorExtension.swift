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
    static var newsTakingCareCategoryBackgroundColor: UIColor {
        return UIColor(displayP3Red: 189/255, green: 207/255, blue: 89/255, alpha: 1.0)
    }
    ///
    static var newsVaillantGroupCategoryBackgroundColor: UIColor {
        return UIColor(displayP3Red: 223/255, green: 232/255, blue: 177/255, alpha: 1.0)
    }
    ///
    static var newsSeparatorLabelBackgroundColor: UIColor {
        return UIColor(red: 228/255, green: 238/255, blue: 185/255, alpha: 1)
    }
  
    ///
    static var eventsRecentMessagesBackgroundColor: UIColor {
        return UIColor(red: 245/255, green: 222/255, blue: 188/255, alpha: 1)
    }
    ///
    static var eventsKlantenCategoryBackgroundColor: UIColor {
        return UIColor(displayP3Red: 231/255, green: 178/255, blue: 108/255, alpha: 1.0)
    }
    ///
    static var eventsPersonelCategoryBackgroundColor: UIColor {
        return UIColor(displayP3Red: 238/255, green: 198/255, blue: 145/255, alpha: 1.0)
    }
    ///
    static var eventsSeparatorLabelBackgroundColor: UIColor {
        return UIColor(red: 238/255, green: 198/255, blue: 145/255, alpha: 1)
    }
    

    ///
    static var surveyRecentBackgroundColor: UIColor {
        return UIColor(red: 232/255, green: 238/255, blue: 246/255, alpha: 1)
    }
    ///
    static var surveyRecentCategoryBackgroundColor: UIColor {
        return steelBlue
    }
    ///
    static var surveySeparatorLabelBackgroundColor: UIColor {
        return UIColor(red: 213/255, green: 215/255, blue: 230/255, alpha: 1)
    }
}
