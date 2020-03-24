//
//  DashboardTableViewCell.swift
//  WeCare
//
//  Created by Admin on 19/03/20.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import UIKit

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
