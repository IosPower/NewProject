//
//  NewsDetailVC.swift
//  WeCare
//
//  Created by Admin on 05/04/20.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import UIKit
import WebKit
import Kingfisher
class NewsDetailVC: UIViewController {
    
    ///
    @IBOutlet weak var headerTitleLabel: UILabel!
    ///
    @IBOutlet weak var imgView: UIImageView!
    ///
    @IBOutlet weak var imgViewHeightConstraint: NSLayoutConstraint!
    ///
    @IBOutlet weak var calenderDateLabel: UILabel!
    
    ///
    @IBOutlet weak var titleLabel: UILabel!
    ///
    @IBOutlet weak var newsWebView: WKWebView!
    ///
    @IBOutlet weak var newsWebViewHeightConstraint: NSLayoutConstraint!
    ///
    var newsModel: NewsDataModel?
    ///
    let closeValue: CGFloat = 0
    ///
    let openValue: CGFloat = 210
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayEventData()
    }
    
    ///
    func displayEventData() {
        guard let model = newsModel else {
            return
        }
        calenderDateLabel.text = model.created_at
        titleLabel.text = model.title
      
        getNewsImage(newsImagePath: model.image)
        
        let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
        newsWebView.navigationDelegate = self
        newsWebView.scrollView.isScrollEnabled = false
        newsWebView.scrollView.bounces = false
        newsWebView.scrollView.showsVerticalScrollIndicator = false
        newsWebView.scrollView.showsHorizontalScrollIndicator = false
        newsWebView.loadHTMLString(headerString + model.descriptionValue, baseURL: nil)
    }
    
    private func getNewsImage(newsImagePath: String?) {
        guard let imagePath = newsImagePath?.replacingOccurrences(of: " ", with: "%20") else {
            imgViewHeightConstraint.constant = closeValue
            return imgView.image = nil
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
        imgView.image = newsImage
        imgViewHeightConstraint.constant = newsImage == nil ? closeValue : openValue
    }
    
    //
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension NewsDetailVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        newsWebView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
            if complete != nil {
                self.newsWebView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
                    self.newsWebViewHeightConstraint.constant = height as! CGFloat
                })
            }
        })
    }
}
