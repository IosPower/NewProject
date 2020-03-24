//
//  SideMenuVC.swift
//  WeCare
//
//  Created by Dinesh on 16/03/2020.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import UIKit

enum BottomMenuHeight: Int {
    case open = 185
    case close = 50
}

class SideMenuVC: UIViewController {
    ///
    @IBOutlet weak var viewStarusbar: UIView!
    ///
    @IBOutlet weak var menuTableView: UITableView!
    ///
    @IBOutlet weak var weCareLabel: UILabel!
    ///
    @IBOutlet weak var vaillantLabel: UILabel!
    ///
    @IBOutlet weak var groupLabel: UILabel!
    ///
    @IBOutlet weak var bottomMenuAppTitleLabel: UILabel!
    ///
    @IBOutlet weak var bottomMenuProfileLabel: UILabel!
    ///
    @IBOutlet weak var bottomMenuInstellingenLabel: UILabel!
    ///
    @IBOutlet weak var bottomMenuLogoutLabel: UILabel!
    ///
    var statusBarColor =  UIColor.white
    ///
    @IBOutlet weak var bottomMenuViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomMenuOpenCloseButton: UIButton!
    
    var bottomMenuHeightObject = BottomMenuHeight.close
    
    var mainDataArray = [[
        "keyName": "BERICHTEN",
        "keyData": [
            ["titleName": "TAKING CARE",
             "color": UIColor(displayP3Red: 189/255, green: 207/255, blue: 89/255, alpha: 1.0)],
            ["titleName": "VAILLANT GROUP",
             "color": UIColor(displayP3Red: 223/255, green: 232/255, blue: 177/255, alpha: 1.0)]
        ],
        "imgName": "icn_menu_news",
        "color": UIColor.lightGreen,
        "isExpand": false
        ], [
            "keyName": "EVENTS",
            "keyData": [
                ["titleName": "KLANTEN",
                 "color": UIColor(displayP3Red: 231/255, green: 178/255, blue: 108/255, alpha: 1.0)],
                ["titleName": "PERSONEEL",
                 "color": UIColor(displayP3Red: 238/255, green: 198/255, blue: 145/255, alpha: 1.0)]
            ],
            "imgName": "icn_menu_event",
            "color" : UIColor.saffron,
            "isExpand": false
        ], [
            "keyName": "ENQUETES",
            "keyData": [],
            "imgName": "icn_menu_inquiries",
            "color" : UIColor.steelBlue,
            "isExpand": false
        ], [
            "keyName": "WIE IS WIE",
            "keyData": [],
            "imgName": "icn_menu_whoiswho",
            "color" : UIColor.grayNew,
            "isExpand": false
        ]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewStarusbar.backgroundColor = statusBarColor
        
        registerViews(forTableView: menuTableView)
    }
    
  
    func registerViews(forTableView tableView: UITableView) {
        // Cell
        tableView.register(UINib(resource: R.nib.sideMenuTableViewCell), forCellReuseIdentifier: "SideMenuTableViewCell")
    }
    
    ///
    @IBAction func homeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    ///
    @IBAction func bottomMenuOpenCloseButtonAction(_ sender: Any) {
        let imgName = bottomMenuHeightObject == .close ? "icn_uparrow" : "icn_downarrow"
        bottomMenuHeightObject = bottomMenuHeightObject == .close ? BottomMenuHeight.open :  BottomMenuHeight.close
        bottomMenuViewHeightConstraint.constant = CGFloat(bottomMenuHeightObject.rawValue)
        bottomMenuOpenCloseButton.setImage(UIImage(named: imgName), for: .normal)
        
        for (index, _) in mainDataArray.enumerated() {
            mainDataArray[index]["isExpand"] = false
        }
        menuTableView.reloadData()
    }
    ///
    @IBAction func bottomMenuProfileButtonAction(_ sender: Any) {
    }
    ///
    @IBAction func bottomMenuInstellingenButtonAction(_ sender: Any) {
    }
    ///
    @IBAction func bottomMenuLogoutButtonAction(_ sender: Any) {
    }
    ///
    @objc func menuButtonActionFromCell(sender: UIButton) {
        let row = sender.tag
        if row == 0 {
                       if let newsVC = R.storyboard.news.newsVC() {
                           self.push(viewController: newsVC)
                       }
                   }
    }
    
    @objc func headerButtonActionFromCell(sender: UIButton) {
        let section = sender.tag
        guard let titleArray =  mainDataArray[section]["keyData"] as? [[String: Any]] else { return }
        if titleArray.count > 0 {
            for (index, data) in mainDataArray.enumerated() {
                if section == index {
                    mainDataArray[index]["isExpand"] = data["isExpand"] as? Bool == false ? true : false
                } else {
                    mainDataArray[index]["isExpand"] = false
                }
            }
            menuTableView.reloadData()
        } else {
           
        }
    }
    
    func hexColorToRgb(hex: String) -> UIColor? {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt32 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }
        return UIColor(displayP3Red: r, green: g, blue: b, alpha: a)
    }
}

// MARK: - UITableViewDataSource
extension SideMenuVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mainDataArray.count
    }
    
    ///
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let titleArray =  mainDataArray[section]["keyData"] as? [[String: Any]], let isExpand = mainDataArray[section]["isExpand"] as? Bool else {return 0}
        return isExpand ? titleArray.count : 0
    }
    
    ///
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellSideMenu = menuTableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell") as? SideMenuTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        if let titleArray =  mainDataArray[indexPath.section]["keyData"] as? [[String: Any]] {
            let cellColor = titleArray[indexPath.row]["color"] as? UIColor
            cellSideMenu.menuTitleLabel.text = titleArray[indexPath.row]["titleName"] as? String ?? ""
            cellSideMenu.viewCell.backgroundColor = cellColor ?? UIColor.black
        }
        cellSideMenu.menuSelectButton.setImage(nil, for: .normal)
        cellSideMenu.menuSelectButton.tag = indexPath.row
        cellSideMenu.menuSelectButton.addTarget(self, action: #selector(menuButtonActionFromCell), for: .touchUpInside)
        return cellSideMenu
    }

}

// MARK: - UITableViewDelegate
extension SideMenuVC: UITableViewDelegate {
    ///
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerMenu = Bundle.main.loadNibNamed(R.nib.sideMenuSectionHeader.name, owner: self, options: nil)?[0] as? SideMenuSectionHeader else { return SideMenuSectionHeader() }
            
        let imgName = mainDataArray[section]["imgName"] as? String ?? ""
        
        let isExpand = mainDataArray[section]["isExpand"] as? Bool ?? false
        
        let titleArray =  mainDataArray[section]["keyData"] as? [[String: Any]] ?? []
            
        let foldUnfoldImage = titleArray.count > 0 ? UIImage(named: isExpand ? "icn_uparrow" : "icn_downarrow") : nil
        
        headerMenu.headerSelectButton.setImage(foldUnfoldImage, for: .normal)
        headerMenu.viewHeader.backgroundColor = mainDataArray[section]["color"] as? UIColor ?? UIColor.black
        headerMenu.headerImgView.image = UIImage(named: imgName)
        headerMenu.headerTitleLabel.text = mainDataArray[section]["keyName"] as? String ?? ""
            headerMenu.headerSelectButton.tag = section
            headerMenu.headerSelectButton.addTarget(self, action: #selector(headerButtonActionFromCell), for: .touchUpInside)
        return headerMenu
    }
    ///
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    ///
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
