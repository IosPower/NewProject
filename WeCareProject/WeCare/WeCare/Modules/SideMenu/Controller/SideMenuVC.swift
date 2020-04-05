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
    
    var sideMenuViewModel = SideMenuViewModel()

    let newsSectionFirstIndexColor = UIColor(displayP3Red: 189/255, green: 207/255, blue: 89/255, alpha: 1.0)
    let newsSectionSecondIndexColor = UIColor(displayP3Red: 223/255, green: 232/255, blue: 177/255, alpha: 1.0)
    
    let newsSectionSubCategoryFirstIndexColor = UIColor(displayP3Red: 139/255, green: 194/255, blue: 74/255, alpha: 1.0)
    let newsSectionSubCategorySecondIndexColor = UIColor(displayP3Red: 155/255, green: 204/255, blue: 101/255, alpha: 1.0)
    
    
    let eventSectionFirstIndexColor = UIColor(displayP3Red: 231/255, green: 178/255, blue: 108/255, alpha: 1.0)
    let eventSectionSecondIndexColor = UIColor(displayP3Red: 238/255, green: 198/255, blue: 145/255, alpha: 1.0)
    
    
    
    
    var CELLHEIGHT = 45
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerViews(forTableView: menuTableView)
        
        callNewsCategoryApiCall()
        callEventCategoryApiCall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        viewStarusbar.backgroundColor = statusBarColor
        viewStarusbar.backgroundColor = UIColor.white
    }
  
    func registerViews(forTableView tableView: UITableView) {
        // Cell
        tableView.register(UINib(resource: R.nib.sideMenuTableViewCell), forCellReuseIdentifier: "SideMenuTableViewCell")
    }
    
    ///
    @IBAction func homeButtonAction(_ sender: Any) {
        if let newsVC = R.storyboard.dashboard.dashboardVC() {
            self.push(viewController: newsVC, animated: false)
        }
    }
    ///
    @IBAction func bottomMenuOpenCloseButtonAction(_ sender: Any) {
        let imgName = bottomMenuHeightObject == .close ? "icn_uparrow" : "icn_downarrow"
        bottomMenuHeightObject = bottomMenuHeightObject == .close ? BottomMenuHeight.open :  BottomMenuHeight.close
        bottomMenuViewHeightConstraint.constant = CGFloat(bottomMenuHeightObject.rawValue)
        bottomMenuOpenCloseButton.setImage(UIImage(named: imgName), for: .normal)
        
        for (index, _) in sideMenuViewModel.sideMenuModelArray.enumerated() {
            sideMenuViewModel.sideMenuModelArray[index].isExpand = false
            for (categoryIndex, _) in sideMenuViewModel.sideMenuModelArray[index].keyData.enumerated() {
                sideMenuViewModel.sideMenuModelArray[index].keyData[categoryIndex].isExpand = false
            }
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
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:menuTableView)
        guard let indexPath = self.menuTableView.indexPathForRow(at: buttonPosition) else {return}
        
         let categoryModelArray = sideMenuViewModel.sideMenuModelArray[indexPath.section].keyData
         let subCategoryArray = categoryModelArray[indexPath.row].newsSubCategoryModelArray
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            if let newsVC = R.storyboard.news.newsVC() {
                newsVC.sideMenuSectionScreen = .news
                self.push(viewController: newsVC, animated: false)
            }
        case (0, 1):
            if subCategoryArray.count > 0 {
                for (index, data) in sideMenuViewModel.sideMenuModelArray[indexPath.section].keyData.enumerated() {
                    if indexPath.row == index {
                        sideMenuViewModel.sideMenuModelArray[indexPath.section].keyData[index].isExpand = data.isExpand == false ? true : false
                    } else {
                        sideMenuViewModel.sideMenuModelArray[indexPath.section].keyData[index].isExpand = false
                    }
                }
                menuTableView.reloadData()
            } else {
                if let newsVC = R.storyboard.news.newsVC() {
                    newsVC.sideMenuSectionScreen = .news
                    self.push(viewController: newsVC, animated: false)
                }
            }
        case (1, 0):
            if let newsVC = R.storyboard.news.newsVC() {
                newsVC.sideMenuSectionScreen = .event
                self.push(viewController: newsVC, animated: false)
            }
        case (1, 0):
            if let newsVC = R.storyboard.news.newsVC() {
                newsVC.sideMenuSectionScreen = .event
                self.push(viewController: newsVC, animated: false)
            }
        default:
            break
        }
    }
    
    @objc func subCategoryButtonActionFromCell(sender: UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:menuTableView)
        guard let indexPath = self.menuTableView.indexPathForRow(at: buttonPosition) else {return}
        
        let categoryModelArray = sideMenuViewModel.sideMenuModelArray[indexPath.section].keyData
        let subCategoryArray = categoryModelArray[indexPath.row].newsSubCategoryModelArray
        
        let subCategoryName = subCategoryArray[sender.tag].message_category_name
        print("subCategoryName", subCategoryName)
        switch indexPath.section {
        case 0:
            // currenly subcategory available only in news
            if let newsVC = R.storyboard.news.newsVC() {
                newsVC.sideMenuSectionScreen = .news
                self.push(viewController: newsVC, animated: false)
            }
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
        
    }
    
    @objc func headerButtonActionFromCell(sender: UIButton) {
        
        // if bottom menu open so close it
        if bottomMenuHeightObject == .open {
            bottomMenuOpenCloseButtonAction(self)
        }
        
        let section = sender.tag
        let categoryModelArray = sideMenuViewModel.sideMenuModelArray[section].keyData
        
        // here if category data available so open or close and if not available so direct navigation according to section
        if categoryModelArray.count > 0 {
            for (index, data) in sideMenuViewModel.sideMenuModelArray.enumerated() {
                if section == index {
                    sideMenuViewModel.sideMenuModelArray[index].isExpand = data.isExpand == false ? true : false
                } else {
                    sideMenuViewModel.sideMenuModelArray[index].isExpand = false
                }
                
                for (categoryIndex, _) in sideMenuViewModel.sideMenuModelArray[index].keyData.enumerated() {
                    sideMenuViewModel.sideMenuModelArray[index].keyData[categoryIndex].isExpand = false
                }
            }
            menuTableView.reloadData()
        } else {
            switch (section) {
            case 0:
                if let newsVC = R.storyboard.news.newsVC() {
                    newsVC.sideMenuSectionScreen = .news
                    self.push(viewController: newsVC, animated: false)
                }
            case 1:
                if let newsVC = R.storyboard.news.newsVC() {
                    newsVC.sideMenuSectionScreen = .event
                    self.push(viewController: newsVC, animated: false)
                }
            case 2:
                if let newsVC = R.storyboard.news.newsVC() {
                    newsVC.sideMenuSectionScreen = .survey
                    self.push(viewController: newsVC, animated: false)
                }
            case 3:
                if let whoVC = R.storyboard.user.userVC() {
                    self.push(viewController: whoVC, animated: false)
                }
            default:
                break
            }
        }
    }
    
    // news category api call
    func callNewsCategoryApiCall() {
        sideMenuViewModel.newsCategoryListAPI(success: {
            self.menuTableView.reloadData()
        
        },  failure: { [weak self] (responseDict) in
            if let message = responseDict[ModelKeys.ResponseKeys.message] as? String {
                self?.showAlert(message: message, buttonTitle: Messages.Button.okButton)
            }
        })
    }
    // event category api call
    func callEventCategoryApiCall() {
        sideMenuViewModel.eventCategoryListAPI(success: {
            self.menuTableView.reloadData()
        },  failure: { [weak self] (responseDict) in
            if let message = responseDict[ModelKeys.ResponseKeys.message] as? String {
                self?.showAlert(message: message, buttonTitle: Messages.Button.okButton)
            }
        })
    }
}

// MARK: - UITableViewDataSource
extension SideMenuVC: UITableViewDataSource {
    ///
    func numberOfSections(in tableView: UITableView) -> Int {
        return sideMenuViewModel.sideMenuModelArray.count
    }
    
    ///
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categoryModelArray = sideMenuViewModel.sideMenuModelArray[section].keyData
        let isExpandSection = sideMenuViewModel.sideMenuModelArray[section].isExpand
        return isExpandSection ? categoryModelArray.count : 0
    }
    
    ///
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellSideMenu = menuTableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell") as? SideMenuTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        let categoryModelArray = sideMenuViewModel.sideMenuModelArray[indexPath.section].keyData
        let subCategoryArray = categoryModelArray[indexPath.row].newsSubCategoryModelArray
        let isExpandSubCategory = categoryModelArray[indexPath.row].isExpand
        
        var heightConstraint = CELLHEIGHT
       
        if subCategoryArray.count > 0 {
            if isExpandSubCategory {
                cellSideMenu.menuSelectButton.setImage(R.image.icn_uparrow(), for: .normal)
                
                // get total height of view cell according to subCategoryArray, by default height 45
                heightConstraint += subCategoryArray.count * CELLHEIGHT
                
                // remove all views from stack view
                for subView in cellSideMenu.verticalStackView.subviews {
                    cellSideMenu.verticalStackView.removeArrangedSubview(subView)
                }
                
                // add subcategory view inside cell
                for (index, data) in subCategoryArray.enumerated() {
                    let viewStackContainer = UIView()
                    viewStackContainer.tag = index
                    
                    switch index {
                    case 0:
                        //
                        viewStackContainer.backgroundColor = newsSectionSubCategoryFirstIndexColor
                    case 1:
                        viewStackContainer.backgroundColor = newsSectionSubCategorySecondIndexColor
                    default:
                        break
                    }
                    
                    // create label and add to view
                    let label = UILabel(frame: CGRect(x: 75, y: Int(12.5), width: (Int(cellSideMenu.bounds.size.width - 75 - 20)), height: 20))
                    label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                    label.text = data.message_category_name.uppercased()
                    label.textColor = UIColor.white
                   
                    let buttonSubCategory = UIButton(frame: CGRect(x: 0, y: 0, width: cellSideMenu.frame.size.width, height: cellSideMenu.frame.size.height))
                    buttonSubCategory.setTitle("", for: .normal)
                    buttonSubCategory.tag = index
                    buttonSubCategory.addTarget(self, action: #selector(subCategoryButtonActionFromCell), for: .touchUpInside)
                    
                    viewStackContainer.addSubview(label)
                    viewStackContainer.addSubview(buttonSubCategory)
                    // add viewStackContainer to verticalStackView which is inside cell
                    cellSideMenu.verticalStackView.addArrangedSubview(viewStackContainer)
                }
            } else {
                cellSideMenu.menuSelectButton.setImage(R.image.icn_downarrow(), for: .normal)
            }
        } else {
            cellSideMenu.menuSelectButton.setImage(nil, for: .normal)
        }
       
        cellSideMenu.viewCellHeightConstraint.constant = CGFloat(heightConstraint)
        
        var cellColor = UIColor.black
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cellColor = newsSectionFirstIndexColor
            case 1:
                cellColor = newsSectionSecondIndexColor
            default:
                break
            }
        case 1:
            // section's cell background color
            switch indexPath.row {
            case 0:
                cellColor = eventSectionFirstIndexColor
                case 1:
                cellColor = eventSectionSecondIndexColor
            default:
                break
            }
        default:
            break
        }
        
        
        cellSideMenu.menuTitleLabel.text = categoryModelArray[indexPath.row].message_category_name.uppercased()
        cellSideMenu.viewCell.backgroundColor = cellColor
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
            
        let imgName = sideMenuViewModel.sideMenuModelArray[section].imgName
        
        let isExpand = sideMenuViewModel.sideMenuModelArray[section].isExpand
        
        let categoryModelArray =  sideMenuViewModel.sideMenuModelArray[section].keyData
            
        let foldUnfoldImage = categoryModelArray.count > 0 ? UIImage(named: isExpand ? "icn_uparrow" : "icn_downarrow") : nil
        
        headerMenu.headerSelectButton.setImage(foldUnfoldImage, for: .normal)
        headerMenu.viewHeader.backgroundColor = sideMenuViewModel.sideMenuModelArray[section].sectionBgColor
        headerMenu.headerImgView.image = UIImage(named: imgName)
        headerMenu.headerTitleLabel.text = sideMenuViewModel.sideMenuModelArray[section].keyName
            headerMenu.headerSelectButton.tag = section
            headerMenu.headerSelectButton.addTarget(self, action: #selector(headerButtonActionFromCell), for: .touchUpInside)
        return headerMenu
    }
    ///
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(CELLHEIGHT)
    }
}
