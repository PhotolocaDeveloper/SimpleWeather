//
//  WeatherDataUiHelper.swift
//  SimpleWeather
//
//  Created by George Lyurko on 27.07.2018.
//  Copyright © 2018 George Lyurko. All rights reserved.
//

import UIKit
class WeatherDataUiHeper {
    
    private var isCelsius: Bool?
    
    init() {
        self.isCelsius = UserDefaultsManager.isUseCelsius()
    }
    
    func fillMainData(currentWeatherData: CurrentWeatherData,feelsLikeLabel: UILabel, timeOfADayLabel: UILabel,tempLabel: UILabel, pressureLabel: UILabel, precipLabel: UILabel, visibilityLabel: UILabel, windSpeedLabel: UILabel, humidityLabel: UILabel, cloudLabel: UILabel) {
        
        humidityLabel.text = String(currentWeatherData.humidity!) + " " + "%"
        cloudLabel.text = String(currentWeatherData.cloud!) + " " + "%"
        
        if currentWeatherData.isDay == 1 {
            timeOfADayLabel.text = LocalizeApp.day.instance
        } else {
            timeOfADayLabel.text = LocalizeApp.night.instance
        }
        
        if isCelsius! == true {
            let tempC = currentWeatherData.tempC?.roundTo(places: 2)
            tempLabel.text = String(tempC!) + " " + "C"
            
            let feelslikeC = currentWeatherData.feelsLikeC?.roundTo(places: 2)
            feelsLikeLabel.text = String(feelslikeC!) + " " + "C"
            
            let pressureC = currentWeatherData.pressureMb?.roundTo(places: 2)
            pressureLabel.text = String(pressureC!) + " " + LocalizeApp.bar.instance
            
            let PrecipMM = currentWeatherData.precipMm?.roundTo(places: 2)
            precipLabel.text = String(PrecipMM!) + " " + LocalizeApp.mm.instance
            
            let visKm = currentWeatherData.visibilityKm?.roundTo(places: 2)
            visibilityLabel.text = String(visKm!) + " " + LocalizeApp.km.instance
            
            let windSpeed = currentWeatherData.windKph?.roundTo(places: 2)
            windSpeedLabel.text = String(windSpeed!) + " " + LocalizeApp.kph.instance
        } else {
            let tempF = currentWeatherData.tempF?.roundTo(places: 2)
            tempLabel.text = String(tempF!) + " " + "F"
            
            let feelslikeF = currentWeatherData.feelsLikeF?.roundTo(places: 2)
            feelsLikeLabel.text = String(feelslikeF!) + " " + "F"
            
            let pressureF = currentWeatherData.pressureIn?.roundTo(places: 2)
            pressureLabel.text = String(pressureF!) + " " + LocalizeApp.inches.instance
            
            let PrecipIn = currentWeatherData.precipIn?.roundTo(places: 2)
            precipLabel.text = String(PrecipIn!) + " " + LocalizeApp.inches.instance
            
            let visMl = currentWeatherData.visibilityMl?.roundTo(places: 2)
            visibilityLabel.text = String(visMl!) + " " + LocalizeApp.ml.instance
            
            let windSpeed = currentWeatherData.windMph?.roundTo(places: 2)
            windSpeedLabel.text = String(windSpeed!) + " " + LocalizeApp.mph.instance
        }
        
        
    }
    
    func fillForecast(weatherForecastData: WeatherForecast, icon: UIImageView, date: UILabel, text: UILabel, avgTemp: UILabel, precip: UILabel) {
        
        text.text = String(weatherForecastData.text)
        icon.kf.setImage(with: makeUrl(iconUrl: weatherForecastData.icon))
        date.text = weatherForecastData.date
        
        if isCelsius == true {
            let avgTempC = weatherForecastData.avgtempC.roundTo(places: 2)
            avgTemp.text = String(avgTempC) + " " + "C"
            
            let precipMm = weatherForecastData.totalprecipMm.roundTo(places: 2)
            precip.text = String(precipMm) + " " + LocalizeApp.mm.instance

        } else {
            let avgTempF = weatherForecastData.avgtempF.roundTo(places: 2)
            avgTemp.text = String(avgTempF) + " " + "F"
            
            let precipIn = weatherForecastData.totalprecipIn.roundTo(places: 2)
            precip.text = String(precipIn) + " " +  LocalizeApp.inches.instance
        }
        
    }
    
    private func makeUrl(iconUrl: String) -> URL {
        let apixuImageUrl = "https:" + iconUrl
        let url = URL(string: String(apixuImageUrl))
        return url!
    }
    
     func fillConditionWeatherData(conditionWeatherData: ConditionWeatherData, weatherDescription: UILabel, icon: UIImageView) {
        
        weatherDescription.text = conditionWeatherData.text
        icon.kf.setImage(with: makeUrl(iconUrl: conditionWeatherData.icon!))
    
    }
    
    
   
    
     func fillLocationWeatherData(locationWeatherData: LocationWeatherData, localTimeLabel: UILabel, cityNameLabel: UILabel) {
        cityNameLabel.text = locationWeatherData.name
        let localTimeWithDate = locationWeatherData.localTime
        let localTime = localTimeWithDate?.dropFirst(10)
        localTimeLabel.text = String(localTime!)
    }
    
}
