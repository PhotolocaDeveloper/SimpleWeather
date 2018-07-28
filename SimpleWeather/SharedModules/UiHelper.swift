//
//  UiHelper.swift
//  SimpleWeather
//
//  Created by George Lyurko on 26.07.2018.
//  Copyright © 2018 George Lyurko. All rights reserved.
//

import UIKit

public class UiHelper {
    
    class func hideStatusbar() {
        UIApplication.shared.isStatusBarHidden = true
    }
    
    class func whiteStatusbar() {
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    class func darkStatusbar() {
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .default
    }
    
    class func getBuildNumber() -> String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        return "\(LocalizeApp.buildNumber.instance)" + " - " + "\(version)"
    }
    
    class func basicAlert(title: String, message: String, vc: UIViewController, complition: @escaping() -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: LocalizeApp.ok.instance, style: .default) { (nil) in
            complition()
        }
        alert.addAction(okAction)
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    
}

extension UIButton {
    func roundCorners(radius: Int) {
        self.layer.cornerRadius = CGFloat(radius)
    }
}

extension UIView {
    func roundView() {
        self.layer.cornerRadius = self.frame.height/2
    }
    
    func makeCornersRounder(radius: Int) {
        self.layer.cornerRadius = CGFloat(radius)
    }
}

