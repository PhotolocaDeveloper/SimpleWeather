//
//  NavigationManager.swift
//  SimpleWeather
//
//  Created by George Lyurko on 26.07.2018.
//  Copyright © 2018 George Lyurko. All rights reserved.
//

import UIKit

public class NavigationManager {
    
    private static let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    private enum ViewNames: String {
        case mainWeatherData = "MainWeatherData"
        case forecastWeather = "WeatherForecast"
        case settings = "Settings"
        case errorView = "ErrorView"
    }
    
    
    class func presentMainWeatherDataScreen(vc: UIViewController) {
        let mainWeatherData = mainStoryboard.instantiateViewController(withIdentifier: ViewNames.mainWeatherData.rawValue) as! WeatherViewController
        vc.navigationController?.pushViewController(mainWeatherData, animated: true)
    }
    
    class func presentSettingsScreen(vc: UIViewController) {
        let settings = mainStoryboard.instantiateViewController(withIdentifier: ViewNames.settings.rawValue) as! SettingsTableViewController
        vc.navigationController?.pushViewController(settings, animated: true)
    }
    
    class func presentForecastWeatherScreen(vc: UIViewController, lat: Double, lon: Double) {
        let forecast = mainStoryboard.instantiateViewController(withIdentifier: ViewNames.forecastWeather.rawValue) as! ForecastTableViewController
        forecast.lat = lat
        forecast.lon = lon
        vc.navigationController?.pushViewController(forecast, animated: true)
    }
    
    class func presentErrorScreen(vc: UIViewController, errorCode: String) {
        let errorScreen = mainStoryboard.instantiateViewController(withIdentifier: ViewNames.errorView.rawValue) as! ErrorViewController
        errorScreen.errorCode = errorCode
        vc.navigationController?.pushViewController(errorScreen, animated: true)
    }
    
    
    
}
