//
//  UserTableViewCell.swift
//  WeCare
//
//  Created by Admin on 26/03/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    ///
    @IBOutlet weak var personNameLabel: UILabel!
    ///
    @IBOutlet weak var personDesignationLabel: UILabel!
    ///
    @IBOutlet weak var imgView: UIImageView!
    ///
    @IBOutlet weak var selectButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
