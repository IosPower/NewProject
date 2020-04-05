//
//  SubCategoryView.swift
//  WeCare
//
//  Created by Admin on 31/03/20.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import UIKit

protocol SubCategorySelectionProtocol: class {
    ///
    func selectSubCatgory(selectedName: String)
}


class SubCategoryView: UIView {
    ///
    @IBOutlet weak var viewContainer: UIView!
    ///
    @IBOutlet weak var viewListHeader: UIView!
    ///
    @IBOutlet weak var subCategoryTableView: UITableView!
    ///
    @IBOutlet weak var categoryTitleLabel: UILabel!
    ///
    @IBOutlet weak var viewListHeightConstraint: NSLayoutConstraint!
    ///
    var subCategoryArray = [SubCategoryModel]()
    
    ///
    weak var delegate: SubCategorySelectionProtocol?
    
    override func awakeFromNib() {
       super.awakeFromNib()
       registerViews(forTableView: subCategoryTableView)
    }
    
    ///
    func registerViews(forTableView tableView: UITableView) {
        tableView.register(UINib(resource: R.nib.subCategoryTableViewCell), forCellReuseIdentifier: "SubCategoryTableViewCell")
    }
    
    ///
    func setupView() {
        viewListHeightConstraint.constant = CGFloat((subCategoryArray.count * 44) + 40)
    }
    
    ///
    @IBAction func closeButtonAction(_ sender: Any) {
        self.removeFromSuperview()
    }
}

// MARK: - UITableViewDataSource
extension SubCategoryView: UITableViewDataSource {
    ///
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategoryArray.count
    }
    ///
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellSubCategory = subCategoryTableView.dequeueReusableCell(withIdentifier: "SubCategoryTableViewCell") as? SubCategoryTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        cellSubCategory.separatorLabel.backgroundColor = viewListHeader.backgroundColor
        cellSubCategory.subCategoryNameLabel.text = subCategoryArray[indexPath.row].message_category_name
        cellSubCategory.selectionStyle = .none
        return cellSubCategory
    }
}

// MARK: - UITableViewDelegate
extension SubCategoryView: UITableViewDelegate {
    ///
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    ///
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryName = subCategoryArray[indexPath.row].message_category_name
        delegate?.selectSubCatgory(selectedName: categoryName)
    }
}
