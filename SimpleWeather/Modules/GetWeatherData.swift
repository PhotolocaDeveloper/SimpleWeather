//
//  GetWeatherData.swift
//  SimpleWeather
//
//  Created by George Lyurko on 26.07.2018.
//  Copyright © 2018 George Lyurko. All rights reserved.
//

import Foundation
import Alamofire

class GetWeatherData {
    
    private var lat: Double?
    private var lon: Double?
    private var lang: String?
    
    private let apiKey = "f3bd169d7b6e40b7b99114809180904"
    
    
    init(lat: Double, lon: Double) {
        self.lon = lon
        self.lat = lat
        lang = LocalizationLang.getAppLocalizationLang()
    }
    
    func getWeatherData(currentWeather: @escaping(_ currentData: CurrentWeatherData) -> Void, conditionWeather: @escaping(_ conditionData: ConditionWeatherData) -> Void,locationWeather: @escaping(_ locationData: LocationWeatherData) -> Void,errorGettingData: @escaping(_ errorMessage: String?) -> Void) {
        
        // Create url with specific data
        let apixuRequest = "https://api.apixu.com/v1/current.json?key=\(apiKey )&lang=\(lang as! String)&q=\(lat as! Double),\(lon as! Double)"
        // Convert into url
        let urlRquest = URL(string: apixuRequest)
        
        // Alamofire request
        request(urlRquest!).responseJSON { (response) in
            
            // Handle error
            guard response.error == nil else {
                errorGettingData(response.error?.localizedDescription)
                return
            }
            
            
            // Get response in json
            let rawJsonWeatherData = response.result.value as? [String: Any]
            
            
            // Acces to current key and save data from this key in dictionary
            if let currentWeatherDictionary = rawJsonWeatherData![keys.current.rawValue] as? [String: Any] {
                // Init current weather class with dictionary that we get
                let currentWeatherData = CurrentWeatherData(CurrentWeatherDictionary: currentWeatherDictionary)
                // Return this class into complition
                currentWeather(currentWeatherData)
                
                // Acces to condition key and save data from this key in dictionary
                if let conditionWeatherDictionary = currentWeatherDictionary[keys.condition.rawValue] as? [String:Any] {
                    // Init condition class with dictionary that we get
                    let conditionWeatherData = ConditionWeatherData(ConditionWeatherDictionary: conditionWeatherDictionary)
                    // Return this class into complition
                    conditionWeather(conditionWeatherData)
                    
                } else {
                    errorGettingData(LocalizeApp.errorGettingsWeatherData.instance)
                }
            } else {
                errorGettingData(LocalizeApp.errorGettingsWeatherData.instance)
            }
            
            // Acces to location key and save data from this key in dictionary
            if let locationWeatherDictionary = rawJsonWeatherData![keys.location.rawValue] as? [String: Any] {
                 // Init location weather class with dictionary that we get
                let locationWeatherData = LocationWeatherData(locationWeatherDictionary: locationWeatherDictionary)
                // Return this class into complition
                locationWeather(locationWeatherData)
            }  else {
                errorGettingData(LocalizeApp.errorGettingsWeatherData.instance)
            }
        }
        
    }
    
    func getForecastWeatherData(successGettingsForecast: @escaping(_ forecastArra:[WeatherForecast]) -> Void, errorGettingData: @escaping(_ errorMessage: String) -> Void) {
        
        let apixuRequestForecast = "https://api.apixu.com/v1/forecast.json?key=\(apiKey )&lang=\(lang as! String)&q=\(lat as! Double),\(lon as! Double)&days=10"
        
        let urlRequest = URL(string: apixuRequestForecast)
        
        request(urlRequest!).responseJSON { (response) in
            guard response.error == nil else {
                errorGettingData((response.error?.localizedDescription)!)
                return
            }
            
            var array = [WeatherForecast]()
            
             let rawJsonForecastWeatherData = response.result.value as? [String: Any]
            
            if let forecast = rawJsonForecastWeatherData![keys.forecast.rawValue] as? [String: Any] {
                
                if let forecastDay = forecast[keys.forecastday.rawValue] as? [[String: Any]] {
                
                    for i in 0...6 {
                        
                        let forecastDataAtIndex = forecastDay[i]
                        let day = forecastDataAtIndex[keys.day.rawValue] as! [String: Any]
                        
                        let condtition = day[keys.condition.rawValue] as! [String: Any]
                        
                        let forecastWeatherData = WeatherForecast(forecastData: day, conditionData: condtition, forecastDayData: forecastDataAtIndex)
                        
                        array.append(forecastWeatherData)
                    }
                    successGettingsForecast(array)
                    
                    
                }
                
            }
        }
    }
    

    
    // Apixu general json keys
    private enum keys: String {
        case current = "current"
        case location = "location"
        case condition = "condition"
        case forecast = "forecast"
        case forecastday = "forecastday"
        case day = "day"
    }
 
    deinit {
        print("GetWeatherData was deinit")
    }
    
}


