//
//  WhoVC.swift
//  WeCare
//
//  Created by Admin on 25/03/20.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import UIKit

class WhoVC: UIViewController {

    @IBOutlet weak var whoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whoTableView.estimatedRowHeight = 110
        whoTableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func menuButtonAction(_ sender: UIButton) {
        CommonMethods.openSideMenu(sender: sender, vc: self, sideMenuStatusBarColor: .grayNew)
    }
    
    @objc func selectButtonActionFromCell() {
           
       }
}

// MARK: - UITableViewDataSource
extension WhoVC: UITableViewDataSource {
    ///
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    ///
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WhoTableViewCell") as? WhoTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        cell.personNameLabel.text = "Dr. Ing. Norbert Schiedeck"
        cell.personDesignationLabel.text = "Chairman of the Vallant Group Management Board"
        cell.imgView.image = UIImage(named: "downloadnature")
        cell.selectButton.tag = indexPath.row
        cell.selectButton.addTarget(self, action: #selector(selectButtonActionFromCell), for: .touchUpInside)
        return cell
    }

}

// MARK: - UITableViewDelegate
extension WhoVC: UITableViewDelegate {
    ///
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
