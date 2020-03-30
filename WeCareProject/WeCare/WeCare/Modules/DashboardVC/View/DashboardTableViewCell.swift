//
//  DashboardTableViewCell.swift
//  WeCare
//
//  Created by Admin on 19/03/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import UIKit
import Kingfisher

class DashboardTableViewCell: UITableViewCell {
    ///
    @IBOutlet weak var dateLabel: UILabel!
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
    @IBOutlet weak var dashboardImageViewWidthConstraint: NSLayoutConstraint!
    
    let closeValue: CGFloat = 20
    let openValue: CGFloat = 147
    
    func displayData(dashboardModel: DashboardDataModel) {
        dateLabel.text = dashboardModel.created_at
        titleLabel.text = dashboardModel.title
        descriptionLabel.text = dashboardModel.short_description
        switch dashboardModel.type {
        case 1:
            categoryTypeImgView.image = R.image.icn_menu_news()
        case 2:
            categoryTypeImgView.image = R.image.icn_menu_event()
        case 3:
            categoryTypeImgView.image = R.image.icn_menu_inquiries()
        default:
            categoryTypeImgView.image = nil
        }
        getDashboardImage(dashboardImagePath: dashboardModel.image)
    }
    
   private func getDashboardImage(dashboardImagePath: String?) {
        guard let imagePath = dashboardImagePath?.replacingOccurrences(of: " ", with: "%20") else {
            dashboardImageViewWidthConstraint.constant = closeValue
            return imgView.image = nil
        }
        if let urlImage = URL(string: imagePath) {
            KingfisherManager.shared.retrieveImage(with: urlImage, options: nil, progressBlock: nil) { [weak self] result in
                switch result {
                case .success(let value):
                    self?.setNewImage(dashboardImage: value.image)
                case .failure(let error):
                    self?.setNewImage(dashboardImage: nil)
                    print("Error: \(error)")
                }
            }
        } else {
            setNewImage(dashboardImage: nil)
        }
    }
    
   private func setNewImage(dashboardImage: UIImage?) {
        imgView.image = dashboardImage
        dashboardImageViewWidthConstraint.constant = dashboardImage == nil ? closeValue : openValue
    }
}
