//
//  ReachabilityManager.swift
//  WeCare
//
//  Created by Dinesh on 14/03/2020.
//  Copyright © 2020 Dinesh Pathak. All rights reserved.
//

import Foundation
import Reachability

class ReachabilityManager {
    
    static let shared = ReachabilityManager()
    
    private var reachability: Reachability!
    
    private init() {
        reachability = try! Reachability()
        
        reachability.whenReachable = { reachability in
            
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            
            //            if reachability.connection != .none {
            //                let alert = self.networkAvailableAlert(onOk: nil)
            //                self.rootViewController()?.present(viewController: alert)
            //            }
        }
        
        reachability.whenUnreachable = { reachability in
            print("Not reachable")
            
            if reachability.connection == .unavailable {
                let alert = self.noNetworkAlert(onCancel: {
                    // TODO: Present no network Screen
                    print("Display no network screen")
                    /*if let noNetworkVC = R.storyboard.login.noNetworkVC() {
                     self.rootViewController()?.push(viewController: noNetworkVC)
                     }*/
                }, onSettings: {
                    // Open network settings
                    if let wifiSettingsUrl = URL(string: "App-Prefs:root=WIFI") { //for WIFI setting app
                        UIApplication.shared.open(wifiSettingsUrl, options: [:], completionHandler: nil)
                    }
                })
                self.rootViewController()?.present(viewController: alert)
            }
        }
    }
    
    var isReachable: Bool {
        return reachability.connection != .unavailable
    }
    
    func startNotifier() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func stopNotifier() {
        reachability.stopNotifier()
    }
    
    private func rootViewController() -> UIViewController? {
        if let appDelegate = UIApplication.shared.delegate,
            let window = appDelegate.window,
            let rootViewController = window?.rootViewController {
            return rootViewController
        }
        return nil
    }
    
    private func noNetworkAlert(onCancel: (() -> Void)?, onSettings: (() -> Void)?) -> UIAlertController {
        let title = "no network connection"
        let message = "Please turn on an internet connection to continue."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { _ in
            onCancel?()
        }))
        alert.addAction(UIAlertAction(title: "SETTINGS", style: .default, handler: { _ in
            onSettings?()
        }))
        return alert
    }
    
    private func networkAvailableAlert(onOk: (() -> Void)?) -> UIAlertController {
        let title = "Internet connection available"
        let message = "The network connection is now available, the MyCourrier24-App switches to online mode."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            onOk?()
        }))
        return alert
    }
}

