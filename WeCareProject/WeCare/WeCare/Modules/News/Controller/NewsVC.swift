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
    
    ///
    var newsViewModel: NewsViewModel?
    ///
    @IBOutlet weak var categoryFirstButton: UIButton!
    ///
    @IBOutlet weak var categorySecondButton: UIButton!
    ///
    @IBOutlet weak var categoryDropDownImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsViewModel = NewsViewModel(vc: self)
        newsTableView.estimatedRowHeight = 162
        newsTableView.rowHeight = UITableView.automaticDimension
        setupView()
        newsListApiCall()
    }
    
    func setupView() {
        categoryDropDownImageView.isHidden = true
    }
    
    @IBAction func menuButtonAction(_ sender: UIButton) {
        CommonMethods.openSideMenu(sender: sender, vc: self, sideMenuStatusBarColor: .lightGreen)
    }
    
    @objc func selectButtonActionFromCell() {
        
    }
    
    @IBAction func categoryFirstButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func categorySecondButtonAction(_ sender: Any) {
        
    }
    
    func newsListApiCall() {
//        if newsViewModel?.newDataArray.count == 0 {
//
//        }
        Constants.window?.showHud()
        newsViewModel?.newsListAPI(success: {
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
        return 2
    }
    
    ///
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellNewsList = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as? NewsTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        var newsObject: NewsDataModel?
        switch indexPath.section {
        case 0:
            cellNewsList.backgroundColor = .newsRecentMessagesBackgroundColor
            cellNewsList.categoryView.backgroundColor = .newsRecentMessagesCategoryBackgroundColor
            newsObject = newsViewModel?.newsRecentMessagesModelArray[indexPath.row]
            
            let latArrayIndex = (newsViewModel?.newsRecentMessagesModelArray.count ?? 0) - 1
            cellNewsList.separatorView.backgroundColor = latArrayIndex == indexPath.row ? UIColor.lightGreen : .clear
        case 1:
            cellNewsList.backgroundColor = .white
            cellNewsList.categoryView.backgroundColor = .lightGreen
            cellNewsList.separatorView.backgroundColor = .clear
            newsObject = newsViewModel?.newDataArray[indexPath.row]
        default:
            break
        }
        cellNewsList.newSelectionView.layer.borderColor = UIColor.newsRecentMessagesBackgroundColor.cgColor
        cellNewsList.newSelectionView.layer.borderWidth = 1.5
        cellNewsList.selectButton.tag = indexPath.row
        cellNewsList.selectButton.addTarget(self, action: #selector(selectButtonActionFromCell), for: .touchUpInside)
        
        guard let newsObjectModel = newsObject else {
            cellNewsList.displayData(date: "", title: "", description: "", imgPath: nil, typeImgName: "icn_menu_news", categoryName: "", index: indexPath.row)
            return cellNewsList
        }
        cellNewsList.displayData(date: newsObjectModel.created_at, title: newsObjectModel.title, description: newsObjectModel.short_description, imgPath: newsObjectModel.image, typeImgName: "icn_menu_news", categoryName: newsObjectModel.category, index: indexPath.row)
        return cellNewsList
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
          guard let newsViewModelObject = newsViewModel else {
              return
          }
          if indexPath.section == 1 && indexPath.row > 0 && (indexPath.row + 1) % (10 * (newsViewModelObject.pageNo - 1)) == 0 {
              newsListApiCall()
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
        
        var sectionTitle = ""
        switch section {
        case 0:
            headerMenu.backgroundColor = .newsRecentMessagesBackgroundColor
            sectionTitle = "VERS VAN DE PERS"
        case 1:
            headerMenu.backgroundColor = .white
            sectionTitle = "ALLE BERICHTEN"
        default:
            break
        }
        headerMenu.newsSectionTitleLabel.text = sectionTitle
        return headerMenu
    }
    
    ///
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}
