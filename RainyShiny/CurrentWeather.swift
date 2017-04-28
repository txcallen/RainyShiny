//
//  CurrentWeather.swift
//  RainyShiny
//
//  Created by Tianchong Xie on 2017-04-27.
//  Copyright © 2017 Tianchong Xie. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather{
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    
    var cityName: String {
        if _cityName == nil{
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil{
            _date = ""
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        let currentDate = formatter.string(from: Date())
        _date = "Today \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil{
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    
    func downloadWeatherDetail(completed: @escaping DownLoadComplete){
        
        
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON{ response in
            let result = response.result
            
            if let dataDic = result.value as? Dictionary<String, Any> {
                
                //parsing the city name from the data
                if let cityname = dataDic["name"] as? String{
                    
                    self._cityName = cityname.capitalized
                    print(self._cityName)
                }
                
                // parsing the weather Type
                if let weather = dataDic["weather"] as? [Dictionary<String, Any>]{
                    
                    if let weatherType = weather[0]["main"] as? String{
                        
                        self._weatherType = weatherType.capitalized
                        print(self._weatherType)
                    }
                    
                }
                
                //parsing the current tempreture
                if let main = dataDic["main"] as? Dictionary<String, Any>{
                    
                    if let currentTemp = main["temp"] as? Double{
                        
                        self._currentTemp = kelvinToCelcius(kelvinValue: currentTemp)
                            
                        print(self._currentTemp)
                        
                    }
                }
                
                
            }
            completed()
        }
        

    }
    
    
}

