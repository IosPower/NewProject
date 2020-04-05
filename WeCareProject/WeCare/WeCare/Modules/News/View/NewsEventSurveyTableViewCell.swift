//
//  NewsEventSurveyTableViewCell.swift
//  WeCare
//
//  Created by Admin on 25/03/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import UIKit
import Kingfisher

class NewsEventSurveyTableViewCell: UITableViewCell {
    
    ///
    @IBOutlet weak var dateAndCateoryLabel: UILabel!
    ///
    @IBOutlet weak var titleLabel: UILabel!
    ///
    @IBOutlet weak var descriptionLabel: UILabel!
    ///
    @IBOutlet weak var imgView: UIImageView!
    ///
    @IBOutlet weak var selectButton: UIButton!
    ///
    @IBOutlet weak var categoryTypeImgView: UIImageView!
    ///
    @IBOutlet weak var categoryNameLabel: UILabel!
    ///
    @IBOutlet weak var newsImageViewWidthConstraint: NSLayoutConstraint!
    ///
    @IBOutlet weak var separatorView: UIView!
    ///
    @IBOutlet weak var categoryView: UIView!
    ///
    @IBOutlet weak var newSelectionView: UIView!
    ///
    @IBOutlet weak var separatorLabel: UILabel!
    ///
    @IBOutlet weak var addressAndEventDataLabel: UILabel!
    ///
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    
    ///
    var sideMenuSectionScreen: SideMenuSectionScreen?
    
    ///
    let closeValue: CGFloat = 20
    
    ///
    let openValue: CGFloat = 147
    
    
    /// setup cell
    /// - Parameters:
    ///   - cellBgColor: cell background color
    ///   - separatorViewBgColor: separator color
    func setupCell(cellBgColor: UIColor, separatorViewBgColor: UIColor) {
        guard let sideMenuSectionScreenObject = sideMenuSectionScreen else {
            return
        }
        var typeImg: UIImage?
        var separatorLabelBgColor = UIColor.clear
        
        var categoryNameTextColor = UIColor.black
        // here category view bgcolor according category WIP
        switch sideMenuSectionScreenObject {
        case .news:
            categoryView.backgroundColor = .newsTakingCareCategoryBackgroundColor
            newSelectionView.layer.borderColor = UIColor.newsRecentMessagesBackgroundColor.cgColor
            separatorLabelBgColor = .newsSeparatorLabelBackgroundColor
            typeImg = R.image.icn_menu_news()
        case .event:
            categoryView.backgroundColor = .eventsKlantenCategoryBackgroundColor
            newSelectionView.layer.borderColor = UIColor.eventsRecentMessagesBackgroundColor.cgColor
            separatorLabelBgColor = .eventsSeparatorLabelBackgroundColor
            typeImg = R.image.icn_menu_event()
        case .survey:
            categoryNameTextColor = .white
            categoryView.backgroundColor = .surveyRecentCategoryBackgroundColor
            newSelectionView.layer.borderColor = UIColor.surveyRecentBackgroundColor.cgColor
            separatorLabelBgColor = .surveySeparatorLabelBackgroundColor
            typeImg = R.image.icn_menu_inquiries()
        }
        
        newSelectionView.layer.borderWidth = 1.5
        categoryTypeImgView.image = typeImg
        separatorLabel.backgroundColor = separatorLabelBgColor
        separatorView.backgroundColor = separatorViewBgColor
        
        categoryNameLabel.textColor = categoryNameTextColor
        
        // this is cell background color
        self.backgroundColor = cellBgColor
    }
    
    /// display data
    /// - Parameters:
    ///   - modelObject:DataModel  object
    ///   - index: index in Int
    func displayData(modelObject: DataModel?, index: Int) {
        guard let sideMenuSectionScreenObject = sideMenuSectionScreen else {
            return
        }
        if let model = modelObject {
            var dateAndCategory = model.created_at
            if !model.category.isEmpty {
                dateAndCategory = dateAndCategory + " l " + model.category
            }
            categoryNameLabel.text = model.category.isEmpty ? sideMenuSectionScreenObject.rawValue : model.category
            dateAndCateoryLabel.text = dateAndCategory
            titleLabel.text = model.title
            descriptionLabel.text = model.short_description
            getNewsImage(newsImagePath: model.image)
            
            titleLabelTopConstraint.constant = (model.address.isEmpty && model.event_start_date.isEmpty && model.event_time.isEmpty) ? 0 : 5
            let eventStartDateAndTime = model.event_start_date + " " + model.event_time
            let resultStr = model.address + (model.address.isEmpty ? "" : (model.event_start_date.isEmpty ? "" : " l ")) + eventStartDateAndTime
            addressAndEventDataLabel.text = resultStr.removeWhiteSpace()
        } else {
            categoryNameLabel.text = ""
            dateAndCateoryLabel.text = ""
            titleLabel.text = ""
            descriptionLabel.text = ""
            addressAndEventDataLabel.text = ""
            getNewsImage(newsImagePath: nil)
            titleLabelTopConstraint.constant = 0
        }
    }
    
   private func getNewsImage(newsImagePath: String?) {
        guard let imagePath = newsImagePath?.replacingOccurrences(of: " ", with: "%20") else {
            newsImageViewWidthConstraint.constant = closeValue
            return imgView.image = nil
        }
        if let urlImage = URL(string: imagePath) {
            KingfisherManager.shared.retrieveImage(with: urlImage, options: nil, progressBlock: nil) { [weak self] result in
                switch result {
                case .success(let value):
                    self?.setNewImage(newsImage: value.image)
                case .failure(let error):
                    self?.setNewImage(newsImage: nil)
                    print("Error: \(error)")
                }
            }
        } else {
            setNewImage(newsImage: nil)
        }
    }
    
  private  func setNewImage(newsImage: UIImage?) {
        imgView.image = newsImage
        newsImageViewWidthConstraint.constant = newsImage == nil ? closeValue : openValue
    }
    
}
