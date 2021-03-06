//
//  UIVIewController+Extension.swift
//  WeCare
//
//  Created by Dinesh on 13/03/2020.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import UIKit
import MBProgressHUD

// MARK: - This extension implement common for all UIViewcontroller setup
extension UIViewController {
    /// common alert controller
       func showAlert(_ title: String = Messages.appTitle, message: String, buttonTitle: String) {
           DispatchQueue.main.async { [unowned self] in
               let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert )
               alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
               self.present(alert, animated: true, completion: nil)
           }
       }
    /// common alert controller
    func showAlert(_ title: String = Messages.appTitle, message: String, buttonTitle: String, completion: @escaping () -> Void) {
        DispatchQueue.main.async { [unowned self] in
            let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert )
            let okAction = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion()
            })
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    ///
    var selfNavigationController: UINavigationController? {
        if let navController = self as? UINavigationController {
            return navController
        }
        return navigationController
    }
    
    
    ///
    var appDelegate: AppDelegate? {
        if let appDel = UIApplication.shared.delegate as? AppDelegate {
            return appDel
        }
        return nil
    }
    
    ///
    var window: UIWindow? {
        return appDelegate?.window
    }
    
    ///
    var rootViewController: UIViewController? {
        return window?.rootViewController
    }
    
    ///
    var rootNavigationController: UINavigationController? {
        return rootViewController as? UINavigationController
    }
    

    func setAsRootController(in window: UIWindow? = nil) {
        func selfWithNavigationController() -> UINavigationController {
            if let navController = self as? UINavigationController {
                return navController
            }
            return UINavigationController(rootViewController: self)
        }
        
        DispatchQueue.main.async {
            if let window = window {
                window.rootViewController = selfWithNavigationController()
            } else if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.window?.rootViewController = selfWithNavigationController()
            }
        }
    }
    
    @discardableResult func push(viewController: UIViewController, animated: Bool = true) -> Bool {
        if let navController = selfNavigationController {
            print(navController.viewControllers)
            DispatchQueue.main.async {
                //self.push_POP_to_ViewController(nav: navController, destinationVC: viewController, isAnimated: animated)
                navController.pushViewController(viewController, animated: animated)
            }
            return true
        } else {
            print("\nERROR: - \(self) is not having NavigationController")
            return false
        }
    }
    
    //MARK:- Push_Pop ViewController
    func push_POP_to_ViewController(nav: UINavigationController, destinationVC: UIViewController, isAnimated:Bool) {
        var VCFound:Bool = false
        let viewControllers:NSArray = nav.viewControllers as NSArray
        var indexofVC:NSInteger = 0
        for  vc  in viewControllers  {
            if (vc as AnyObject).nibName == (destinationVC.nibName){
                VCFound = true
                break
            }else{
                indexofVC += 1
            }
        }
        if VCFound == true {
            nav.popToViewController(viewControllers.object(at: indexofVC) as! UIViewController, animated: isAnimated)
        }else{
            nav.pushViewController(destinationVC , animated: isAnimated)
        }
    }
    
    func present(viewController: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            self.present(viewController, animated: animated, completion: nil)
        }
    }
    
    func showNavigationBar() {
        navigationController?.navigationBar.isHidden = false
    }
    
    func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
}

// MARK: - Window Extension
extension UIWindow {
    ///
    func showHud(title: String? = nil) {
        hideHud()
        DispatchQueue.main.async(execute: {
            let hudMbProgress = MBProgressHUD.showAdded(to: self, animated: true)
            hudMbProgress.contentColor = UIColor.white
            if title == nil {
                hudMbProgress.label.text = ""
            } else {
                hudMbProgress.label.text = title ?? ""
            }
            hudMbProgress.bezelView.alpha = 1.0
            hudMbProgress.bezelView.color = UIColor.clear
            hudMbProgress.bezelView.style = .solidColor
            hudMbProgress.backgroundView.color = UIColor.black
            hudMbProgress.backgroundView.alpha = 0.5
            hudMbProgress.backgroundView.style = .solidColor
        })
    }
    ///
    func hideHud() {
        DispatchQueue.main.async(execute: {
            MBProgressHUD.hide(for: self, animated: true)
        })
    }
}
