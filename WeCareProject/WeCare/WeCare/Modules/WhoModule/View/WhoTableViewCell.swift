//
//  WhoTableViewCell.swift
//  WeCare
//
//  Created by Admin on 25/03/20.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import UIKit

class WhoTableViewCell: UITableViewCell {

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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
