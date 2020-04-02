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
    ///
    @IBOutlet weak var userImageHeightConstraint: NSLayoutConstraint!
    
    var userModel: UserModel?
    
    ///
    let closeValue: CGFloat = 0
    ///
    let openValue: CGFloat = 360
    
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
               userImageHeightConstraint.constant = closeValue
               return userImgView.image = nil
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
           userImgView.image = newsImage
           userImageHeightConstraint.constant = newsImage == nil ? closeValue : openValue
       }
       
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
