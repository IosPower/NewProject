//
//  UserVC.swift
//  WeCare
//
//  Created by Admin on 26/03/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import UIKit
import Kingfisher

class UserVC: UIViewController {

    @IBOutlet weak var userTableView: UITableView!
    
    ///
    var userViewModel: UserViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userViewModel = UserViewModel(vc: self)
        userTableView.estimatedRowHeight = 110
        userTableView.rowHeight = UITableView.automaticDimension
        
        userListApiCall()
    }
    
    @IBAction func menuButtonAction(_ sender: UIButton) {
        CommonMethods.openSideMenu(sender: sender, vc: self, sideMenuStatusBarColor: .grayNew)
    }
    
    @objc func selectButtonActionFromCell(sender: UIButton) {
        if let userDetailVC = R.storyboard.user.userDetailVC(),
            let userModelArray = userViewModel?.userModelArray, sender.tag < userModelArray.count {
            let model = userModelArray[sender.tag]
            userDetailVC.userModel = model
            self.push(viewController: userDetailVC, animated: false)
        }
    }
    
    func userListApiCall() {
        Constants.window?.showHud()
        userViewModel?.userListAPI(success: {
            Constants.window?.hideHud()
            self.userTableView.reloadData()
        }, failure: { [weak self] (responseDict) in
            if let message = responseDict[ModelKeys.ResponseKeys.message] as? String {
                self?.showAlert(message: message, buttonTitle: Messages.Button.okButton)
            }
        })
    }
}

// MARK: - UITableViewDataSource
extension UserVC: UITableViewDataSource {
    ///
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModel?.userModelArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let userModel = userViewModel else {
            return
        }
        
        if indexPath.row > 0 && (indexPath.row + 1) % (10 * (userModel.pageNo - 1)) == 0 {
            if userModel.userModelArray.count < userModel.totalCount {
                if (userModel.pageNo - 1) < Int(round(Float(userModel.totalCount)/Float(userModel.perPageCount))) {
                    print("indexPath.row", indexPath.row)
                    print("userModel.userModelArray.count", userModel.userModelArray.count)
                    print("userModel.pageNo", userModel.pageNo - 1)
                    userListApiCall()
                }
            }
        }
    }
    
    ///
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as? UserTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        guard let userModel = userViewModel?.userModelArray[indexPath.row] else {
            cell.personNameLabel.text = ""
            cell.personDesignationLabel.text = ""
            cell.imgView.image = nil
            cell.selectButton.tag = indexPath.row
            cell.selectButton.addTarget(self, action: #selector(selectButtonActionFromCell), for: .touchUpInside)
            return cell
        }
        
        cell.personNameLabel.text = userModel.first_name + userModel.last_name
        cell.personDesignationLabel.text = userModel.department_name
       
        setUserImage(userImagePath: userModel.profile_image, cell: cell)
        
//        cell.imgView.image = UIImage(named: "downloadnature")
        cell.selectButton.tag = indexPath.row
        cell.selectButton.addTarget(self, action: #selector(selectButtonActionFromCell), for: .touchUpInside)
        return cell
    }

    func setUserImage(userImagePath: String, cell: UserTableViewCell) {
        let imagePath = userImagePath.replacingOccurrences(of: " ", with: "%20")
        if let urlImage = URL(string: imagePath) {
            KingfisherManager.shared.retrieveImage(with: urlImage, options: nil, progressBlock: nil) { result in
                switch result {
                case .success(let value):
                   cell.imgView.image = value.image
                case .failure(let error):
                    cell.imgView.image = nil
                    print("Error: \(error)")
                }
            }
        }
    }
    
}

// MARK: - UITableViewDelegate
extension UserVC: UITableViewDelegate {
    ///
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
