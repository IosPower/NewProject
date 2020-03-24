//
//  NewsTableViewCell.swift
//  WeCare
//
//  Created by Admin on 25/03/20.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
