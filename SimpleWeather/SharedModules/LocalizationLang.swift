//
//  GetAppLocalizationLanguage.swift
//  SimpleWeather
//
//  Created by George Lyurko on 26.07.2018.
//  Copyright © 2018 George Lyurko. All rights reserved.
//

import Foundation

public class LocalizationLang {
    
    // Getting current app lang and use it to create request 
    class func getAppLocalizationLang() -> String {
        let appLanguage = Locale.preferredLanguages[0]
        let arr = appLanguage.components(separatedBy: "-")
        let deviceLanguage = arr.first
        
        if deviceLanguage == "ru" {
            return "ru"
        } else {
            return "en"
        }
    }
    
}
