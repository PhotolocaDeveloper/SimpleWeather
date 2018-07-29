//
//  PreviewWeatherViewController.swift
//  SimpleWeather
//
//  Created by George Lyurko on 29.07.2018.
//  Copyright © 2018 George Lyurko. All rights reserved.
//

import UIKit


class PreviewWeatherViewController: UIViewController {
    @IBOutlet weak var ForecastImage: UIImageView!
    @IBOutlet weak var MaxTenpTitleLabel: UILabel!
    @IBOutlet weak var MaxTempLabel: UILabel!
    @IBOutlet weak var MinTempTitleLabel: UILabel!
    @IBOutlet weak var MinTempLabel: UILabel!
    @IBOutlet weak var MaxWindSpeedTitleLabel: UILabel!
    @IBOutlet weak var MaxWindSpeedLabel: UILabel!
    @IBOutlet weak var AvghumidityTitleLabel: UILabel!
    @IBOutlet weak var AvghumidityLabel: UILabel!
    @IBOutlet weak var AvgVisTitleLabel: UILabel!
    @IBOutlet weak var AvgVisLabel: UILabel!
    @IBOutlet weak var BackImageView: UIView!
    @IBOutlet weak var BackView: UIView!
    
    var moreInfoForecastData: WeatherForecast?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        localizePreviewScreen()
        let weatherDataUiHelper = WeatherDataUiHeper()
        
        weatherDataUiHelper.fillPreviewForecastData(weatherForecastData: moreInfoForecastData!, icon: ForecastImage, maxTempLabel: MaxTempLabel, minTempLabel: MinTempLabel, maxWindSpeedLabel: MaxWindSpeedLabel, avgHumidityLabel: AvghumidityLabel, avgVisLabel: AvgVisLabel)
        
        BackView.makeCornersRounder(radius: 10)
        BackImageView.roundView()
        
        BackView.dropShadow()
        BackImageView.dropShadow()
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        makeNavBarTransclusent()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
   
    
    
    private func makeNavBarTransclusent() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func localizePreviewScreen() {
        MaxWindSpeedTitleLabel.text = LocalizeApp.maxWindSpeed.instance
        MaxTenpTitleLabel.text = LocalizeApp.maxTemp.instance
        MinTempTitleLabel.text = LocalizeApp.minTemp.instance
        AvghumidityTitleLabel.text = LocalizeApp.averageHumidity.instance
        AvgVisTitleLabel.text = LocalizeApp.AverageVis.instance
    }
    

    
}
