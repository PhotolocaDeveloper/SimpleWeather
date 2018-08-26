//
//  LocalizeModule.swift
//  SimpleWeather
//
//  Created by George Lyurko on 26.07.2018.
//  Copyright © 2018 George Lyurko. All rights reserved.
//

import Foundation

public enum LocalizeApp: String {
    
    case buildNumber = "BuildNumber"
    case ok = "Ok"
    case errorGettingsWeatherData = "ErrorGettingsWeatherData"
    case data = "Data"
    case location = "Location"
    case errorGettingsLocation = "ErrorGettingsLocation"
    case localTime = "LocalTime"
    case feelsLike = "FeelsLike"
    case pressure = "Pressure"
    case precip = "Precip"
    case hmidity = "Humidity"
    case cloud = "Cloud"
    case timeOfDay = "TimeOfDay"
    case visibility = "Visibility"
    case day = "Day"
    case night = "Night"
    case kph = "Kph"
    case mph = "Mph"
    case mm = "mm"
    case forecast = "Forecast"
    case windSpeed = "WindSpeed"
    case lat = "Lat"
    case lon = "Lon"
    case inches = "in"
    case ml = "ml"
    case km = "km"
    case averageTemp = "AverageTemp"
    case precipitation = "Precipitation"
    case settings = "Settings"
    case selectMetricsSystem = "SelectMetricsSystem"
    case viewCode = "ViewCode"
    case contactUs = "ContactUs"
    case makeBetterDesc = "MakeBetterDesc"
    case us = "US"
    case eu = "EU"
    case bar = "Bar"
    case sendinMailErroDesc = "SendinMailErroDesc"
    case sendingError = "SendingError"
    case retry = "Retry"
    case maxTemp = "MaxTemp"
    case minTemp = "MinTemp"
    case maxWindSpeed = "MaxWindSpeed"
    case averageHumidity = "AverageHumidity"
    case AverageVis = "AverageVis"
    case kmShort = "kmShort"
    case cel = "cel"
    case phar = "pharh"
    
    
    var instance: String  {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
    
}

