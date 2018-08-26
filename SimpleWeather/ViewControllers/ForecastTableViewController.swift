//
//  ForecastTableViewController.swift
//  SimpleWeather
//
//  Created by George Lyurko on 26.07.2018.
//  Copyright © 2018 George Lyurko. All rights reserved.
//

import UIKit
import ProgressHUD
class ForecastTableViewController: UITableViewController {
    
    var lat: Double!
    var lon: Double!
    private let uiThread = DispatchQueue.main
    private let generalThread = DispatchQueue.global(qos: .userInteractive)
    
    private var dimView: UIView!
    private var arrayOfForecastData: [WeatherForecast]!
    private var weatherDataUiHeper: WeatherDataUiHeper!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavBar()
        UiHelper.darkStatusbar()
        
        uiThread.async {
            self.dimScreen()
            ProgressHUD.show()
        }
        
        generalThread.async {
            self.weatherDataUiHeper = WeatherDataUiHeper.init()
            
            let getWeatherData = GetWeatherData.init(lat: self.lat, lon: self.lon)
            getWeatherData.getForecastWeatherData(successGettingsForecast: { (weatherForcastArray) in
                self.arrayOfForecastData = weatherForcastArray
                self.tableView.reloadData()
                self.dissmisDimView()
            }) { (error) in
                self.dissmisDimView()
                ProgressHUD.dismiss()
                NavigationManager.presentErrorScreen(vc: self, errorCode: error)
            }
        }
        
    }
    
    private func dissmisDimView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.dimView.alpha = 0
            ProgressHUD.dismiss()
        })
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
        hideBackBtnTitle()
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.title = LocalizeApp.forecast.instance
    }
    
    private func hideBackBtnTitle() {
        let backButton = UIBarButtonItem()
        backButton.title = " "
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrayOfForecastData == nil {
            return 0
        } else {
             return arrayOfForecastData.count
        }

       
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        uiThread.async {
            let dataForPreview = self.arrayOfForecastData[indexPath.row]
            NavigationManager.presentPreviewWeather(vc: self, forecastWeatherData: dataForPreview)
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ForecastTableViewCell
        
        let dataToFill = arrayOfForecastData[indexPath.row]
        
        // Func to fill data into rows
        weatherDataUiHeper.fillForecast(weatherForecastData: dataToFill, icon: cell.ForecastImage, date: cell.ForecastDateLabel, text: cell.ForecastTextDescription!, avgTemp: cell.AvgTempLabel, precip: cell.PrecipLabel)

        cell.selectionStyle = .none
        
        return cell
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        arrayOfForecastData = nil
        weatherDataUiHeper = nil
        weatherDataUiHeper = nil
        dimView = nil 
    }
    

    

}
