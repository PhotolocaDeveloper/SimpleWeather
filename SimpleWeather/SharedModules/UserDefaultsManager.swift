//
//  UserDefaultsManager.swift
//  SimpleWeather
//
//  Created by George Lyurko on 26.07.2018.
//  Copyright © 2018 George Lyurko. All rights reserved.
//

import Foundation

public class UserDefaultsManager {
    
    /* We save or fetch type of metrics taht user choose by using user defaults */
    
    class func setToCelsius() {
        UserDefaults.standard.set(true, forKey: "IsUseCelsius")
    }
    
    class func setToFahrenheit() {
        UserDefaults.standard.set(false, forKey: "IsUseCelsius")
    }
    
    class func isUseCelsius() -> Bool {
    
        let isCelsius = UserDefaults.standard.object(forKey: "IsUseCelsius") as? Bool
        
        guard isCelsius != nil else {
            return true
        }
        
        if isCelsius == true {
            return true
        } else {
            return false
        }
        
    }
    
    
    
}
