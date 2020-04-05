//
//  DashboardVC.swift
//  WeCare
//
//  Created by Dinesh on 14/03/2020.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import UIKit
import SideMenu

class DashboardVC: UIViewController {
    
    // MARK: - Outlet

    @IBOutlet weak var dashboardTableView: UITableView!
    ///
    @IBOutlet weak var newsView: UIView!
    ///
    @IBOutlet weak var eventView: UIView!
    ///
    @IBOutlet weak var surveyView: UIView!
    ///
    @IBOutlet weak var userListView: UIView!
    ///
    @IBOutlet weak var newsCountLabel: UILabel!
    ///
    @IBOutlet weak var eventCountLabel: UILabel!
    ///
    @IBOutlet weak var surveyCountLabel: UILabel!
    ///
    @IBOutlet weak var newsLabel: UILabel!
    ///
    @IBOutlet weak var eventLabel: UILabel!
    ///
    @IBOutlet weak var surveyLabel: UILabel!
    ///
    @IBOutlet weak var userLabel: UILabel!
    
    ///
    var dashboardViewModel: DashboardViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dashboardViewModel = DashboardViewModel(vc: self)
        setupSideMenu()
        newsListApiCall()
    }
    
    // MARK: - Helper methods
   
    /// Setting SideMenu
    func setupSideMenu() {
        guard let sideMenuNavigationController = R.storyboard.sideMenu().instantiateViewController(withIdentifier: "SideMenuNavigationController") as? SideMenuNavigationController,
            sideMenuNavigationController.viewControllers.count > 0 else { return }
       
        sideMenuNavigationController.presentationStyle.backgroundColor = UIColor.clear
        sideMenuNavigationController.menuWidth = UIScreen.main.bounds.width - 80
        sideMenuNavigationController.presentationStyle = .viewSlideOutMenuIn
        sideMenuNavigationController.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        sideMenuNavigationController.navigationBar.isHidden = true
        sideMenuNavigationController.statusBarEndAlpha = 0
        SideMenuManager.default.leftMenuNavigationController = sideMenuNavigationController
    }
    
    func displayDashboardData() {
        newsCountLabel.text = "\(dashboardViewModel?.message_unread_count ?? 0)"
        eventCountLabel.text = "\(dashboardViewModel?.event_unread_count ?? 0)"
        surveyCountLabel.text = "\(dashboardViewModel?.survey_unread_count ?? 0)"
    }
    
    @IBAction func menuButtonAction(_ sender: UIButton) {
        CommonMethods.openSideMenu(sender: sender, vc: self)
    }
    
    @IBAction func newsButtonAction(_ sender: UIButton) {
        if let newsEventSurveyVC = R.storyboard.news.newsEventSurveyVC() {
            newsEventSurveyVC.sideMenuSectionScreen = .news
            self.push(viewController: newsEventSurveyVC, animated: false)
        }
    }
    
    @IBAction func eventsButtonAction(_ sender: UIButton) {
        if let newsEventSurveyVC = R.storyboard.news.newsEventSurveyVC() {
            newsEventSurveyVC.sideMenuSectionScreen = .event
            self.push(viewController: newsEventSurveyVC, animated: false)
        }
    }
    
    @IBAction func surveyButtonAction(_ sender: UIButton) {
        if let newsEventSurveyVC = R.storyboard.news.newsEventSurveyVC() {
            newsEventSurveyVC.sideMenuSectionScreen = .survey
            self.push(viewController: newsEventSurveyVC, animated: false)
        }
    }
    
    @IBAction func userButtonAction(_ sender: UIButton) {
        if let whoVC = R.storyboard.user.userVC() {
            self.push(viewController: whoVC, animated: false)
        }
    }
    
    
    @objc func selectButtonActionFromCell() {
        
    }
    
    func newsListApiCall() {
        Constants.window?.showHud()
        dashboardViewModel?.dashboardListAPI(success: {
            Constants.window?.hideHud()
            self.displayDashboardData()
            self.dashboardTableView.reloadData()
        }, failure: { [weak self] (responseDict) in
            Constants.window?.hideHud()
            if let message = responseDict[ModelKeys.ResponseKeys.message] as? String {
                self?.showAlert(message: message, buttonTitle: Messages.Button.okButton)
            }
        })
    }
}

// MARK: - UITableViewDataSource
extension DashboardVC: UITableViewDataSource {
    ///
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dashboardViewModel?.dashboardDataModelArray.count ?? 0
    }
    
    ///
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellDashboard = tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell") as? DashboardTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        guard let dashboardModel = dashboardViewModel?.dashboardDataModelArray[indexPath.row] else {
            return cellDashboard
        }
        
        cellDashboard.displayData(dashboardModel: dashboardModel)
        cellDashboard.selectButton.tag = indexPath.row
        cellDashboard.selectButton.addTarget(self, action: #selector(selectButtonActionFromCell), for: .touchUpInside)
        return cellDashboard
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let newsViewModelObject = dashboardViewModel else {
            return
        }
        if indexPath.section == 1 && indexPath.row > 0 && (indexPath.row + 1) % (10 * (newsViewModelObject.pageNo - 1)) == 0 {
            newsListApiCall()
        }
    }
}

// MARK: - UITableViewDelegate
extension DashboardVC: UITableViewDelegate {
    ///
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 167
    }
}
