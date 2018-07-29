//
//  WeatherViewController.swift
//  SimpleWeather
//
//  Created by George Lyurko on 26.07.2018.
//  Copyright © 2018 George Lyurko. All rights reserved.
//

import UIKit
import CoreLocation
import Kingfisher
import ProgressHUD

class WeatherViewController: UIViewController, CLLocationManagerDelegate, UIScrollViewDelegate {
    @IBOutlet weak var CityNameLabel: UILabel!
    @IBOutlet weak var ForecastImage: UIImageView!
    @IBOutlet weak var TemretureLabel: UILabel!
    @IBOutlet weak var WeatherTextLabel: UILabel!
    @IBOutlet weak var LocalTimeTitleLabel: UILabel!
    @IBOutlet weak var LocalTimeLabel: UILabel!
    @IBOutlet weak var FeelsLikeTitleLabel: UILabel!
    @IBOutlet weak var FeelsLikeLabel: UILabel!
    @IBOutlet weak var WindSpeedTitleLabel: UILabel!
    @IBOutlet weak var WindSpeedLabel: UILabel!
    @IBOutlet weak var PressureTitleLabel: UILabel!
    @IBOutlet weak var PressureLabel: UILabel!
    @IBOutlet weak var PrecipTitleLabel: UILabel!
    @IBOutlet weak var PrecipLabel: UILabel!
    @IBOutlet weak var HumidityTitleLabel: UILabel!
    @IBOutlet weak var HumidityLabel: UILabel!
    @IBOutlet weak var CloudTitleLabel: UILabel!
    @IBOutlet weak var CloudLabel: UILabel!
    @IBOutlet weak var TimeOfDayTitleLabel: UILabel!
    @IBOutlet weak var TimeOfDayLabel: UILabel!
    @IBOutlet weak var VisibilityTitleLabel: UILabel!
    @IBOutlet weak var VisibilityLabel: UILabel!
    @IBOutlet weak var LatLabel: UILabel!
    @IBOutlet weak var LonLabel: UILabel!
    @IBOutlet weak var ForecastOutlet: UIButton!
    @IBOutlet weak var LatTitleLabel: UILabel!
    @IBOutlet weak var LonTitleLabel: UILabel!
    @IBOutlet weak var RoundView: UIView!
    @IBOutlet weak var ScrollView: UIScrollView!
    
    private var dimView: UIView!

    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation!
    
    private var getWeatherModule: GetWeatherData!
    
    private var lat: Double?
    private var lon: Double?
    
    private var weatherDataUiHeper: WeatherDataUiHeper!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    
        weatherDataUiHeper = WeatherDataUiHeper.init()
        ScrollView.delegate = self
        UiHelper.whiteStatusbar()
        setupNavBar()
        determineMyCurrentLocation()
        localizeApp()
        RoundView.roundView()
        ForecastOutlet.roundCorners(radius: 10)
    }
    
    
    private func dimScreen() {
        let window = UIApplication.shared.keyWindow!
        self.dimView = UIView()
        self.dimView.frame = self.view.bounds
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dimView.addSubview(blurEffectView)
        
        window.addSubview(self.dimView)
    }
    
    private func setupNavBar() {
        makeTransparentNavBar()
        setupLeftButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dimScreen()
        ProgressHUD.show()
    }
    
    
    private func setupLeftButton() {
        let settingsButton = UIButton(type: .system)
        settingsButton.setImage(UIImage(named: "Menu")?.withRenderingMode(.alwaysOriginal), for: .normal)
        settingsButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        settingsButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingsButton)
    }
    
    
    
    @objc func menuButtonAction() {
        NavigationManager.presentSettingsScreen(vc: self)
    }
    
    // Disable buttom scroll bounce
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
            scrollView.contentOffset.y = scrollView.contentSize.height - scrollView.bounds.height
        }
    }
    
    private func makeTransparentNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    private func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        } else {
            dissmisDimView()
            ProgressHUD.dismiss()
            NavigationManager.presentErrorScreen(vc: self, errorCode: LocalizeApp.errorGettingsLocation.instance)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[0] as CLLocation
        
        lat = currentLocation.coordinate.latitude
        lon = currentLocation.coordinate.longitude
        print("Lat = \(lat!)"); print("Lon = \(lon!)")
        
        if lat != nil && lon != nil {
            
            // Set lat and lon label text
            DispatchQueue.main.async {
                let lat = self.lat?.roundTo(places: 5)
                let lon = self.lon?.roundTo(places: 5)
                self.LatLabel.text = String(lat!)
                self.LonLabel.text = String(lon!)
            }
            
        
            getWeatherModule = GetWeatherData(lat: lat!, lon: lon!)
            getWeatherModule.getWeatherData(currentWeather: { (currentWeatherData) in
                
                DispatchQueue.main.async {
    
                 // fill date func
                    self.weatherDataUiHeper.fillMainData(currentWeatherData: currentWeatherData, feelsLikeLabel: self.FeelsLikeLabel, timeOfADayLabel: self.TimeOfDayLabel, tempLabel: self.TemretureLabel, pressureLabel: self.PressureLabel, precipLabel: self.PrecipLabel, visibilityLabel: self.VisibilityLabel, windSpeedLabel: self.WindSpeedLabel, humidityLabel: self.HumidityLabel, cloudLabel: self.CloudLabel)

                }
                
            }, conditionWeather: { (conditionWeatherData) in
                DispatchQueue.main.async {
                    
                     // fill date func
                    self.weatherDataUiHeper.fillConditionWeatherData(conditionWeatherData: conditionWeatherData, weatherDescription: self.WeatherTextLabel, icon: self.ForecastImage)
                    
                    self.dissmisDimView()
                    
                }
                
            }, locationWeather: { (locationWeatherData) in
                // fill date func
                self.weatherDataUiHeper.fillLocationWeatherData(locationWeatherData: locationWeatherData, localTimeLabel: self.LocalTimeLabel, cityNameLabel: self.CityNameLabel)
            }) { (error) in
                ProgressHUD.dismiss()
                self.dissmisDimView()
                NavigationManager.presentErrorScreen(vc: self, errorCode: error!)
            }
            
            locationManager.stopUpdatingLocation()
            
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dissmisDimView()
        ProgressHUD.dismiss()
        NavigationManager.presentErrorScreen(vc: self, errorCode: error.localizedDescription)
    }
    
    private func dissmisDimView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.dimView.alpha = 0
            ProgressHUD.dismiss()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        locationManager = nil
        currentLocation = nil
    }

    
    @IBAction func ForecastAction(_ sender: UIButton) {
        NavigationManager.presentForecastWeatherScreen(vc: self, lat: lat!, lon: lon!)
    }
    
    private func localizeApp() {
        self.LocalTimeTitleLabel.text = LocalizeApp.localTime.instance
        self.FeelsLikeTitleLabel.text = LocalizeApp.feelsLike.instance
        self.WindSpeedTitleLabel.text = LocalizeApp.windSpeed.instance
        self.PrecipTitleLabel.text = LocalizeApp.precip.instance
        self.HumidityTitleLabel.text = LocalizeApp.hmidity.instance
        self.CloudTitleLabel.text = LocalizeApp.cloud.instance
        self.TimeOfDayTitleLabel.text = LocalizeApp.timeOfDay.instance
        self.VisibilityTitleLabel.text = LocalizeApp.visibility.instance
        self.LatTitleLabel.text = LocalizeApp.lat.instance
        self.LonTitleLabel.text = LocalizeApp.lon.instance
        PressureTitleLabel.text = LocalizeApp.pressure.instance
        ForecastOutlet.setTitle(LocalizeApp.forecast.instance, for: .normal)
    }


}

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        let roundedDouble = (self * divisor).rounded() / divisor
        return roundedDouble
    }
}
