import UIKit
import WebKit
import Kingfisher
class EventDetailVC: UIViewController {
    
    ///
    @IBOutlet weak var headerTitleLabel: UILabel!
    ///
    @IBOutlet weak var imgView: UIImageView!
    ///
    @IBOutlet weak var imgViewHeightConstraint: NSLayoutConstraint!
    ///
    @IBOutlet weak var calenderDateLabel: UILabel!
    
    ///
    @IBOutlet weak var eventDateLocationView: UIView!
    
    ///
    @IBOutlet weak var startDateLabel: UILabel!
    ///
    @IBOutlet weak var endDateLabel: UILabel!
    ///
    @IBOutlet weak var startTimeLabel: UILabel!
    ///
    @IBOutlet weak var locationLabel: UILabel!
    
    ///
    @IBOutlet weak var startDateDetailLabel: UILabel!
    ///
    @IBOutlet weak var endDateDetailLabel: UILabel!
    ///
    @IBOutlet weak var startTimeDetailLabel: UILabel!
    ///
    @IBOutlet weak var locationDetailLabel: UILabel!
    ///
    @IBOutlet weak var titleLabel: UILabel!
    ///
    @IBOutlet weak var eventWebView: WKWebView!
    ///
    @IBOutlet weak var eventWebViewHeightConstraint: NSLayoutConstraint!
    ///
    var eventModel: DataModel?
    ///
    var eventDateLocationViewBgColor = UIColor.saffron
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
        eventDateLocationView.backgroundColor = eventDateLocationViewBgColor
        
        guard let model = eventModel else {
            return
        }
        calenderDateLabel.text = model.created_at
        titleLabel.text = model.title
        startDateDetailLabel.text = model.event_start_date
        endDateDetailLabel.text = model.event_end_date
        startTimeDetailLabel.text = model.event_time
        locationDetailLabel.text = model.address
        
        getNewsImage(newsImagePath: model.image)
        
        let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
        eventWebView.navigationDelegate = self
        eventWebView.scrollView.isScrollEnabled = false
        eventWebView.scrollView.bounces = false
        eventWebView.scrollView.showsVerticalScrollIndicator = false
        eventWebView.scrollView.showsHorizontalScrollIndicator = false
        eventWebView.loadHTMLString(headerString + model.descriptionValue, baseURL: nil)
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

extension EventDetailVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        eventWebView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
            if complete != nil {
                self.eventWebView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
                    self.eventWebViewHeightConstraint.constant = height as! CGFloat
                })
            }
        })
    }
}
