//
//  NewsVC.swift
//  WeCare
//
//  Created by Admin on 25/03/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    
    var sideMenuSectionScreen = SideMenuSectionScreen.news
    ///
    @IBOutlet weak var screenHeaderImgView: UIImageView!
    ///
    @IBOutlet weak var headerView: UIView!
    ///
    @IBOutlet weak var screenTitleLabel: UILabel!
    ///
    var newsViewModel: NewsViewModel?
    ///
    @IBOutlet weak var categoryFirstButton: UIButton!
    ///
    @IBOutlet weak var categorySecondButton: UIButton!
    ///
    @IBOutlet weak var categoryDropDownImageView: UIImageView!
    ///
    @IBOutlet weak var bottomCategoryView: UIView!
    ///
    @IBOutlet weak var bottomFirstCategoryView: UIView!
    ///
    @IBOutlet weak var bottomSecondCategoryView: UIView!
    ///
    @IBOutlet weak var bottomCategoryViewBottomConstraint: NSLayoutConstraint!
    ///
    var typeValue = 1
    ///
    var subCategoryView: SubCategoryView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsViewModel = NewsViewModel(vc: self)
        newsViewModel?.sideMenuSectionScreen = sideMenuSectionScreen
        newsTableView.estimatedRowHeight = 162
        newsTableView.rowHeight = UITableView.automaticDimension
        setupView()
    }
    
    func setupView() {
        var imgName = ""
        var headerViewColor = UIColor.clear
        switch sideMenuSectionScreen {
        case .news:
            typeValue = 1
            imgName = "icn_menu_news"
            headerViewColor = .lightGreen
            bottomCategoryView.backgroundColor = .newsRecentMessagesBackgroundColor
            bottomFirstCategoryView.backgroundColor = .newsTakingCareCategoryBackgroundColor
            bottomSecondCategoryView.backgroundColor = .newsVaillantGroupCategoryBackgroundColor
            bottomCategoryView.isHidden = false
            bottomCategoryViewBottomConstraint.constant = 79
        case .event:
            typeValue = 1
            imgName = "icn_menu_event"
            headerViewColor = .saffron
            bottomCategoryView.backgroundColor = .eventsRecentMessagesBackgroundColor
            bottomFirstCategoryView.backgroundColor = .eventsKlantenCategoryBackgroundColor
            bottomSecondCategoryView.backgroundColor = .eventsPersonelCategoryBackgroundColor
            bottomCategoryView.isHidden = false
            bottomCategoryViewBottomConstraint.constant = 79
        case .survey:
            typeValue = 0
            imgName = "icn_menu_inquiries"
            headerViewColor = .steelBlue
            bottomCategoryView.isHidden = true
            bottomCategoryViewBottomConstraint.constant = 40
        }
        newsListApiCall(type: typeValue, isResetData: false)
        // set screen title name
        screenTitleLabel.text = sideMenuSectionScreen.rawValue
        screenHeaderImgView.image = UIImage(named: imgName)
        headerView.backgroundColor = headerViewColor
        
        categoryDropDownImageView.isHidden = true
    }
    
    @IBAction func menuButtonAction(_ sender: UIButton) {
        var sideMenuStatusBarColor = UIColor.white
        switch sideMenuSectionScreen {
        case .news:
            sideMenuStatusBarColor = .lightGreen
        case .event:
            sideMenuStatusBarColor = .saffron
        case .survey:
            sideMenuStatusBarColor = .steelBlue
        }
        CommonMethods.openSideMenu(sender: sender, vc: self, sideMenuStatusBarColor: sideMenuStatusBarColor)
    }
    
    @objc func selectButtonActionFromCell(sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to:  newsTableView)
        let indexPath = newsTableView.indexPathForRow(at:buttonPosition)
        
        guard let indexPathValue = indexPath else {
            return
        }
        
        var modelObject: NewsDataModel?
        if indexPathValue.section == 0 {
            modelObject = newsViewModel?.newsRecentMessagesModelArray[indexPathValue.row]
        } else {
            modelObject = newsViewModel?.newDataArray[indexPathValue.row]
        }
        
        switch sideMenuSectionScreen {
        case .news:
            break
        case .event:
            if let eventDetailVC = R.storyboard.news.eventDetailVC() {
                eventDetailVC.eventModel = modelObject
                eventDetailVC.eventDateLocationViewBgColor = .eventsRecentMessagesBackgroundColor
                self.push(viewController: eventDetailVC, animated: false)
            }
        case .survey:
            break
        }
    }
    
    @IBAction func categoryFirstButtonAction(_ sender: Any) {
        typeValue = 1
        newsListApiCall(type: typeValue, isResetData: true)
    }
    
    @IBAction func categorySecondButtonAction(_ sender: Any) {
        guard let categoryArray = newsViewModel?.newsCategoryModelArray, categoryArray.count > 1  else {
            return
        }
        if (newsViewModel?.newsCategoryModelArray ?? []).count > 1 {
            var color = UIColor.black
            switch sideMenuSectionScreen {
            case .news:
                color = .lightGreen
            case .event:
                color = .saffron
            case .survey:
                color = .steelBlue
            }
            
            if let viewNew = Bundle.main.loadNibNamed("SubCategoryView", owner: self, options: nil)?[0] as? SubCategoryView {
                viewNew.frame = CGRect(x: 0, y: 0, width: Constants.screenWidth, height: Constants.screenHeight)
                viewNew.delegate = self
                viewNew.categoryTitleLabel.text = categoryArray[1].message_category_name.capitalized
                viewNew.subCategoryArray = categoryArray[1].newsSubCategoryModelArray
                viewNew.setupView()
                viewNew.viewListHeader.backgroundColor = color
                
                subCategoryView = viewNew
                
                self.view.addSubview(viewNew)
                self.view.bringSubviewToFront(viewNew)
            }
        }
    }
    
    func newsListApiCall(type: Int, isResetData: Bool) {
//        if newsViewModel?.newDataArray.count == 0 {
//
//        }
        Constants.window?.showHud()
        newsViewModel?.newsListAPI(type: type, isResetData: isResetData, success: {
            Constants.window?.hideHud()
            self.displayCategoryData()
            self.newsTableView.reloadData()
            
        }, failure: { [weak self] (responseDict) in
            Constants.window?.hideHud()
            if let message = responseDict[ModelKeys.ResponseKeys.message] as? String {
                self?.showAlert(message: message, buttonTitle: Messages.Button.okButton)
            }
        })
    }
    
    func displayCategoryData()  {
        guard let categoryArray = newsViewModel?.newsCategoryModelArray, categoryArray.count > 0 else {
            return
        }
        categoryFirstButton.setTitle(categoryArray[0].message_category_name, for: .normal)
        if categoryArray.count > 1 {
            categorySecondButton.setTitle(categoryArray[1].message_category_name, for: .normal)
            if categoryArray[1].newsSubCategoryModelArray.count > 0 {
                 categoryDropDownImageView.isHidden = false
            }
        }
    }
    
    func getDataModelAndCellBGColorAndSeparatorColorAndCategoryImage(indexPath: IndexPath) -> (newsObject: NewsDataModel?, cellBgColor: UIColor, separatorViewBgColor: UIColor) {
        var newsObject: NewsDataModel?
        var cellBgColor = UIColor.white
        var separatorViewBgColor = UIColor.clear
        switch indexPath.section {
        case 0:
            switch sideMenuSectionScreen {
            case .news:
                cellBgColor = .newsRecentMessagesBackgroundColor
                separatorViewBgColor = .lightGreen
            case .event:
                cellBgColor = .eventsRecentMessagesBackgroundColor
                separatorViewBgColor = .saffron
            case .survey:
                cellBgColor = .surveyRecentBackgroundColor
                separatorViewBgColor = .steelBlue
            }
            newsObject = newsViewModel?.newsRecentMessagesModelArray[indexPath.row]
            let latArrayIndex = (newsViewModel?.newsRecentMessagesModelArray.count ?? 0) - 1
            separatorViewBgColor = latArrayIndex == indexPath.row ? separatorViewBgColor : .clear
        case 1:
            newsObject = newsViewModel?.newDataArray[indexPath.row]
        default:
            break
        }
        return (newsObject, cellBgColor, separatorViewBgColor)
    }
}
// MARK: - UITableViewDataSource
extension NewsVC: UITableViewDataSource {
    ///
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return newsViewModel?.newsRecentMessagesModelArray.count ?? 0
        case 1:
            return newsViewModel?.newDataArray.count ?? 0
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsViewModel?.sectionHeaderArray().count ?? 0
    }
    
    ///
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellNewsList = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as? NewsTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        cellNewsList.sideMenuSectionScreen = sideMenuSectionScreen
        
        let tupleValues = getDataModelAndCellBGColorAndSeparatorColorAndCategoryImage(indexPath: indexPath)
        
        cellNewsList.setupCell(cellBgColor: tupleValues.cellBgColor, separatorViewBgColor: tupleValues.separatorViewBgColor)
        
        cellNewsList.selectButton.tag = indexPath.row
        cellNewsList.selectButton.addTarget(self, action: #selector(selectButtonActionFromCell), for: .touchUpInside)
        
        cellNewsList.displayData(modelObject: tupleValues.newsObject, index: indexPath.row)
        return cellNewsList
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
          guard let newsViewModelObject = newsViewModel else {
              return
          }
          if indexPath.section == 1 && indexPath.row > 0 && (indexPath.row + 1) % (10 * (newsViewModelObject.pageNo - 1)) == 0 {
            newsListApiCall(type: typeValue, isResetData: false)
          }
      }
}

// MARK: - UITableViewDelegate
extension NewsVC: UITableViewDelegate {
    ///
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    ///
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerMenu = Bundle.main.loadNibNamed(R.nib.newsSectionHeaderView.name, owner: self, options: nil)?[0] as? NewsSectionHeaderView else { return NewsSectionHeaderView() }
      
        switch sideMenuSectionScreen {
        case .news:
            headerMenu.sectionSeparatorLabel.backgroundColor = .newsSeparatorLabelBackgroundColor
            headerMenu.backgroundColor = section == 0 ? .newsRecentMessagesBackgroundColor: .white
        case .event:
            headerMenu.sectionSeparatorLabel.backgroundColor = .eventsSeparatorLabelBackgroundColor
            headerMenu.backgroundColor = section == 0 ? .eventsRecentMessagesBackgroundColor: .white
        case .survey:
            headerMenu.sectionSeparatorLabel.backgroundColor = .surveySeparatorLabelBackgroundColor
            headerMenu.backgroundColor = section == 0 ? UIColor.surveyRecentBackgroundColor: .white
        }
        headerMenu.newsSectionTitleLabel.text = newsViewModel?.sectionHeaderArray()[section] ?? ""
        return headerMenu
    }
    
    ///
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}
extension NewsVC: SubCategorySelectionProtocol {
    func selectSubCatgory(selectedName: String) {
        subCategoryView?.removeFromSuperview()
        typeValue = 2
        newsListApiCall(type: typeValue, isResetData: true)
    }
}
