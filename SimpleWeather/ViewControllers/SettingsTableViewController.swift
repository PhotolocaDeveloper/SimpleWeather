//
//  SettingsTableViewController.swift
//  SimpleWeather
//
//  Created by George Lyurko on 26.07.2018.
//  Copyright © 2018 George Lyurko. All rights reserved.
//

import UIKit
import ProgressHUD
import SafariServices
import MessageUI

class SettingsTableViewController: UITableViewController, UITextViewDelegate, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var BuildNumberLabel: UILabel!
    @IBOutlet weak var MetricSystemLabel: UILabel!
    @IBOutlet weak var SegmentSwitcher: UISegmentedControl!
    @IBOutlet weak var ViewSourceCodeLabel: UILabel!
    @IBOutlet weak var GitHubOutlet: UIButton!
    @IBOutlet weak var ContactUsLabel: UILabel!
    @IBOutlet weak var ContactUsButtonOutlet: UIButton!
    @IBOutlet weak var IconBuildNumberOutlet: UIView!
    @IBOutlet weak var MetricSystemOutlet: UIView!
    @IBOutlet weak var ViewSourceCodeOutlet: UIView!
    @IBOutlet weak var ContactUsOutlet: UIView!
    @IBOutlet weak var ContactUsTip: UILabel!
    
    private let gitHubUrl = "https://github.com/PhotolocaDeveloper/SimpleWeather"
    private let email = "georglyurko@yandex.ru"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        IconBuildNumberOutlet.makeCornersRounder(radius: 10)
        MetricSystemOutlet.makeCornersRounder(radius: 10)
        ViewSourceCodeOutlet.makeCornersRounder(radius: 10)
        ContactUsOutlet.makeCornersRounder(radius: 10)
        
        IconBuildNumberOutlet.dropShadow()
        MetricSystemOutlet.dropShadow()
        ViewSourceCodeOutlet.dropShadow()
        ContactUsOutlet.dropShadow()
        
        UiHelper.darkStatusbar()
        localizeSettingsScreen()
        setupNavBar()
        setupSegmentFont()
        setupLongButtonHold()
        setupSegmentState()
        
        ContactUsButtonOutlet.setTitle(email, for: .normal)
        GitHubOutlet.setTitle(gitHubUrl, for: .normal)
    }
    
    private func setupSegmentFont() {
        if let font = UIFont(name: "HeadingCompressedPro-Bold", size: 20) {
            SegmentSwitcher.setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
        } else {
            print("error")
        }
        
    }
    
    @IBAction func ContactUsButton(_ sender: UIButton) {
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            print("error")
        }
    }
    
    
    private func setupLongButtonHold() {
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(sender:)))
        ContactUsButtonOutlet.addGestureRecognizer(longGesture)
    }
    
    @objc func longTap(sender : UIGestureRecognizer){
        print("Long tap")
        UIPasteboard.general.string = ContactUsButtonOutlet.titleLabel?.text
        
        if sender.state == .ended {
            ProgressHUD.showSuccess()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func ViewSourceCode(_ sender: UIButton) {
        let url = URL(string: gitHubUrl)
        if UIApplication.shared.canOpenURL(url!) {
            let safariView = SFSafariViewController(url: url!)
            present(safariView, animated: true, completion: nil)
        } else {
            print("Error")
        }
    }
    
    private func setupNavBar() {
        hideBackBtnTitle()
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.title = LocalizeApp.settings.instance
    }
    
    private func hideBackBtnTitle() {
        let backButton = UIBarButtonItem()
        backButton.title = " "
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    
    @IBAction func SegmentAction(_ sender: UISegmentedControl) {
        
        if SegmentSwitcher.selectedSegmentIndex == 0 {
            UserDefaultsManager.setToCelsius()
            print(UserDefaultsManager.isUseCelsius())
        } else if SegmentSwitcher.selectedSegmentIndex == 1 {
            UserDefaultsManager.setToFahrenheit()
            print(UserDefaultsManager.isUseCelsius())
        }
        
    }
    
    private func setupSegmentState() {
        if UserDefaultsManager.isUseCelsius() == true {
            SegmentSwitcher.selectedSegmentIndex = 0
        } else if UserDefaultsManager.isUseCelsius() == false {
             SegmentSwitcher.selectedSegmentIndex = 1
        } else {
             SegmentSwitcher.selectedSegmentIndex = 0
        }
    }
    
    private func localizeSettingsScreen() {
        MetricSystemLabel.text = LocalizeApp.selectMetricsSystem.instance
        ViewSourceCodeLabel.text = LocalizeApp.viewCode.instance
        ContactUsLabel.text = LocalizeApp.contactUs.instance
        ContactUsTip.text = "*" + " " + LocalizeApp.makeBetterDesc.instance
        SegmentSwitcher.setTitle(LocalizeApp.eu.instance, forSegmentAt: 0)
        SegmentSwitcher.setTitle(LocalizeApp.us.instance, forSegmentAt: 1)
        
        BuildNumberLabel.text = UiHelper.getBuildNumber()
    }
    
    private func configureMailController() -> MFMailComposeViewController {
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients([email])
        mailComposer.setSubject("Simple weather app suggestions")
        mailComposer.setMessageBody("", isHTML: false)
        
        return mailComposer
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
    }
    
   
    
    
    
}
