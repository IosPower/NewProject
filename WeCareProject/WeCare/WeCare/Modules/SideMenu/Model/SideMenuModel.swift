//
//  SideMenuModel.swift
//  WeCare
//
//  Created by Admin on 05/04/20.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import UIKit

struct SideMenuModel {
    ///
    var keyName = ""
    ///
    var keyData: [CategoryModel] = []
    ///
    var imgName = ""
    ///
    var sectionBgColor = UIColor.white
    ///
    var isExpand = false
    
    public init(keyName: String, keyData: [CategoryModel], imgName: String, color: UIColor, isExpand: Bool) {
        self.keyName = keyName
        self.keyData = keyData
        self.imgName = imgName
        self.sectionBgColor = color
        self.isExpand = isExpand
    }
}
