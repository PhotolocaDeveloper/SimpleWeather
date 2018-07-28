//
//  ErrorViewController.swift
//  SimpleWeather
//
//  Created by George Lyurko on 28.07.2018.
//  Copyright © 2018 George Lyurko. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {
    @IBOutlet weak var BuildNumberTitle: UILabel!
    @IBOutlet weak var ErrorTextLabel: UILabel!
    @IBOutlet weak var RetryButtonOutlet: UIButton!
    
    var errorCode: String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        BuildNumberTitle.text = UiHelper.getBuildNumber()
        ErrorTextLabel.text = errorCode
        RetryButtonOutlet.setTitle(LocalizeApp.retry.instance, for: .normal)
        RetryButtonOutlet.roundCorners(radius: 10)
        makeNavBarTransclusent()
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    

    private func makeNavBarTransclusent() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func RetryAction(_ sender: UIButton) {
        NavigationManager.presentMainWeatherDataScreen(vc: self)
    }
    

}
