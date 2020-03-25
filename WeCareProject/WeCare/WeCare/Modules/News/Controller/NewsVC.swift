//
//  NewsVC.swift
//  WeCare
//
//  Created by Admin on 25/03/20.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func menuButtonAction(_ sender: UIButton) {
        CommonMethods.openSideMenu(sender: sender, vc: self, sideMenuStatusBarColor: .lightGreen)
    }
    
    @objc func selectButtonActionFromCell() {
        
    }
}
// MARK: - UITableViewDataSource
extension NewsVC: UITableViewDataSource {
    ///
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    ///
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellProjectList = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as? NewsTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        cellProjectList.dateLabel.text = "21 JAN 2020"
        cellProjectList.titleLabel.text = "Lorem ipsum dolor sit amet"
        cellProjectList.descriptionLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
        cellProjectList.imgView.image = UIImage(named: "downloadnature")
        cellProjectList.categoryTypeImgView.image = UIImage(named: "icn_menu_event")
        cellProjectList.selectButton.tag = indexPath.row
        cellProjectList.selectButton.addTarget(self, action: #selector(selectButtonActionFromCell), for: .touchUpInside)
        return cellProjectList
    }

}

// MARK: - UITableViewDelegate
extension NewsVC: UITableViewDelegate {
    ///
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 167
    }
}
