//
//  WeatherData.swift
//  SimpleWeather
//
//  Created by George Lyurko on 26.07.2018.
//  Copyright © 2018 George Lyurko. All rights reserved.
//

import Foundation

class CurrentWeatherData {
    
    var tempC: Double?
    var tempF: Double?
    var feelsLikeC: Double?
    var feelsLikeF: Double?
    var windMph: Double?
    var windKph: Double?
    var pressureMb: Double?
    var pressureIn: Double?
    var precipMm: Double?
    var precipIn: Double?
    var humidity: Int?
    var cloud: Int?
    var isDay: Int?
    var visibilityKm: Double?
    var visibilityMl: Double?
    
    private struct CurrentKeys {
        static let tempC = "temp_c"
        static let tempF = "temp_f"
        static let feelsLikeC = "feelslike_c"
        static let feelsLikeF = "feelslike_f"
        static let windMph = "wind_mph"
        static let windKph = "wind_kph"
        static let pressureMb = "pressure_mb"
        static let pressureIn = "pressure_in"
        static let precipMm = "precip_mm"
        static let precipIn = "precip_in"
        static let humidity = "humidity"
        static let cloud = "cloud"
        static let isDay = "is_day"
        static let visibilityKm = "vis_km"
        static let visibilityMl = "vis_miles"
    }
    
    init(CurrentWeatherDictionary: [String: Any]) {
        self.tempC = CurrentWeatherDictionary[CurrentKeys.tempC] as? Double
        self.tempF = CurrentWeatherDictionary[CurrentKeys.tempF] as? Double
        self.feelsLikeC = CurrentWeatherDictionary[CurrentKeys.feelsLikeC] as? Double
        self.feelsLikeF = CurrentWeatherDictionary[CurrentKeys.feelsLikeF] as? Double
        self.windKph = CurrentWeatherDictionary[CurrentKeys.windKph] as? Double
        self.windMph = CurrentWeatherDictionary[CurrentKeys.windMph] as? Double
        self.pressureMb = CurrentWeatherDictionary[CurrentKeys.pressureMb] as? Double
        self.pressureIn = CurrentWeatherDictionary[CurrentKeys.pressureIn] as? Double
        self.precipIn = CurrentWeatherDictionary[CurrentKeys.precipIn] as? Double
        self.precipMm = CurrentWeatherDictionary[CurrentKeys.precipMm] as? Double
        self.humidity = CurrentWeatherDictionary[CurrentKeys.humidity] as? Int
        self.cloud = CurrentWeatherDictionary[CurrentKeys.cloud] as? Int
        self.isDay = CurrentWeatherDictionary[CurrentKeys.isDay] as? Int
        self.visibilityKm = CurrentWeatherDictionary[CurrentKeys.visibilityKm] as? Double
        self.visibilityMl = CurrentWeatherDictionary[CurrentKeys.visibilityMl] as? Double
    }
    
}

class WeatherForecast {
    var avgtempC: Double!
    var avgtempF: Double!
    
    var maxTempF: Double!
    var maxTempC: Double!
    
    var minTempC: Double!
    var minTempF: Double!
    
    var maxWindSpeedKph: Double!
    var maxWindSpeedMph: Double!
    var avgvisKm: Double!
    var avgvisMiles: Double!
    var avghumidity: Double!
    
    
    var totalprecipMm: Double!
    var totalprecipIn: Double!
    var text: String!
    var icon: String!
    var date: String!
    
    private enum weatherForecastKeys: String {
        case avgtempC = "avgtemp_c"
        case avgtempF = "avgtemp_f"
        case totalprecipMm = "totalprecip_mm"
        case totalprecipIn = "totalprecip_in"
        case icon = "icon"
        case text = "text"
        case date = "date"
        case maxTempF = "maxtemp_f"
        case maxTempC = "maxtemp_c"
        case minTempC = "mintemp_c"
        case minTempF = "mintemp_f"
        case maxWindSpeedKph = "maxwind_kph"
        case maxWindSpeedMph = "maxwind_mph"
        case avgvisKm = "avgvis_km"
        case avgvisMiles = "avgvis_miles"
        case avghumidity = "avghumidity"
    }
    
    init(forecastData:[String: Any], conditionData: [String: Any], forecastDayData: [String: Any]) {
        self.avgtempC = forecastData[weatherForecastKeys.avgtempC.rawValue] as? Double
        self.avgtempF = forecastData[weatherForecastKeys.avgtempF.rawValue] as? Double
        self.totalprecipIn = forecastData[weatherForecastKeys.totalprecipIn.rawValue] as? Double
        self.totalprecipMm = forecastData[weatherForecastKeys.totalprecipMm.rawValue] as? Double
        self.text = conditionData[weatherForecastKeys.text.rawValue] as? String
        self.icon = conditionData[weatherForecastKeys.icon.rawValue] as? String
        self.date = forecastDayData[weatherForecastKeys.date.rawValue] as? String
        self.maxTempC = forecastData[weatherForecastKeys.maxTempC.rawValue] as? Double
        self.maxTempF = forecastData[weatherForecastKeys.maxTempF.rawValue] as? Double
        self.maxWindSpeedKph = forecastData[weatherForecastKeys.maxWindSpeedKph.rawValue] as? Double
        self.maxWindSpeedMph = forecastData[weatherForecastKeys.maxWindSpeedMph.rawValue] as? Double
        self.avgvisKm = forecastData[weatherForecastKeys.avgvisKm.rawValue] as? Double
        self.avgvisMiles = forecastData[weatherForecastKeys.avgvisMiles.rawValue] as? Double
        self.avghumidity = forecastData[weatherForecastKeys.avghumidity.rawValue] as? Double
        self.minTempC = forecastData[weatherForecastKeys.minTempC.rawValue] as? Double
        self.minTempF = forecastData[weatherForecastKeys.minTempF.rawValue] as? Double
    }
    
    
}

class ConditionWeatherData {
    var text: String?
    var icon: String?
    
    private struct ConditionKeys {
        static let text = "text"
        static let icon = "icon"
    }
    
    init(ConditionWeatherDictionary: [String: Any]) {
        self.text = ConditionWeatherDictionary[ConditionKeys.text] as? String
        self.icon = ConditionWeatherDictionary[ConditionKeys.icon] as? String
    }
}

class LocationWeatherData {
    
    var name: String?
    var localTime: String?
    
    private struct LocationKeys {
        static let name = "name"
        static let localtime = "localtime"
    }
    
    init(locationWeatherDictionary: [String: Any]) {
        self.name = locationWeatherDictionary[LocationKeys.name] as? String
        self.localTime = locationWeatherDictionary[LocationKeys.localtime] as? String
    }
    
}
