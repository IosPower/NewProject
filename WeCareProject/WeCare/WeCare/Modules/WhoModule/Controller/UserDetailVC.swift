//
//  UserDetailVC.swift
//  WeCare
//
//  Created by Admin on 01/04/20.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import UIKit
import Kingfisher
class UserDetailVC: UIViewController {
    
    ///
    @IBOutlet weak var userImgView: UIImageView!
    ///
    @IBOutlet weak var nameLabel: UILabel!
    ///
    @IBOutlet weak var emailLabel: UILabel!
    ///
    @IBOutlet weak var telephoneLabel: UILabel!
    ///
    @IBOutlet weak var mobileLabel: UILabel!
    ///
    @IBOutlet weak var departmentLabel: UILabel!
    
    ///
    @IBOutlet weak var nameDetailLabel: UILabel!
    ///
    @IBOutlet weak var emailDetailLabel: UILabel!
    ///
    @IBOutlet weak var telephoneDetailLabel: UILabel!
    ///
    @IBOutlet weak var mobileDetailLabel: UILabel!
    ///
    @IBOutlet weak var departmentDetailLabel: UILabel!
   
    var userModel: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayDetails()
    }
    
    func displayDetails()  {
        guard let userDetailModel = userModel else {
            return
        }
        nameDetailLabel.text = userDetailModel.first_name + " " + userDetailModel.last_name
        emailDetailLabel.text = userDetailModel.email
        telephoneDetailLabel.text = userDetailModel.mobile
        mobileDetailLabel.text = userDetailModel.mobile
        departmentDetailLabel.text = userDetailModel.department_name
        
        getNewsImage(newsImagePath: userDetailModel.profile_image)
    }
    
    private func getNewsImage(newsImagePath: String?) {
        guard let imagePath = newsImagePath?.replacingOccurrences(of: " ", with: "%20") else {
            return userImgView.image = nil
        }
        if let urlImage = URL(string: imagePath) {
            KingfisherManager.shared.retrieveImage(with: urlImage, options: nil, progressBlock: nil) { [weak self] result in
                switch result {
                case .success(let value):
                    self?.userImgView.image = value.image
                case .failure(let error):
                    self?.userImgView.image = nil
                    print("Error: \(error)")
                }
            }
        } else {
            userImgView.image = nil
        }
    }

    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
