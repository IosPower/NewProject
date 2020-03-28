//
//  NewsTableViewCell.swift
//  WeCare
//
//  Created by Admin on 25/03/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {
    
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
    
    let closeValue: CGFloat = 20
    let openValue: CGFloat = 147
    
    func displayData(date: String, title: String, description: String, imgPath: String?, typeImgName: String, categoryName: String, index: Int) {
        
        var dateAndCategory = date
        if !categoryName.isEmpty {
            dateAndCategory = dateAndCategory + " l " + categoryName
        }
        categoryNameLabel.text = categoryName
        dateAndCateoryLabel.text = dateAndCategory
        titleLabel.text = title
        descriptionLabel.text = description
        categoryTypeImgView.image = UIImage(named: typeImgName)
        getNewsImage(newsImagePath: imgPath)
    }
    
    func getNewsImage(newsImagePath: String?) {
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
    
    func setNewImage(newsImage: UIImage?) {
        imgView.image = nil
        newsImageViewWidthConstraint.constant = newsImage == nil ? closeValue : openValue
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
