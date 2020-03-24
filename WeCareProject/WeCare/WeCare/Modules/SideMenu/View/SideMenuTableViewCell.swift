//
//  SideMenuTableViewCell.swift
//  WeCare
//
//  Created by Admin on 22/03/20.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    ///
    @IBOutlet weak var menuTitleLabel: UILabel!
    ///
    @IBOutlet weak var menuSelectButton: UIButton!
    ///
    @IBOutlet weak var viewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
