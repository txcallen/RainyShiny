//
//  Forecast.swift
//  RainyShiny
//
//  Created by Tianchong Xie on 2017-04-27.
//  Copyright © 2017 Tianchong Xie. All rights reserved.
//

import UIKit
import Alamofire

class Forecast{
    private var _date: String!
    private var _highTemp: Double!
    private var _lowTemp: Double!
    private var _weatherType: String!
    
    var date: String{
        if _date == nil{
            _date = ""
        }
        return _date
    }
    
    var weatherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: Double{
        if _highTemp == nil {
        _highTemp = 0.0
        }
        return _highTemp
    }
    
    var lowTemp: Double{
        if _lowTemp == nil {
            _lowTemp = 0.0
        }
        return _lowTemp
    }
    
    
    init(dataDic: Dictionary<String, Any>) {
        
        if let tempreture = dataDic["temp"] as? Dictionary<String, Any>{
            
            if let min = tempreture["min"] as? Double{
                _lowTemp = kelvinToCelcius(kelvinValue: min)
            }
            
            if let max = tempreture["max"] as? Double{
                _highTemp = kelvinToCelcius(kelvinValue: max)
            }
        }
        
            if let weather = dataDic["weather"] as? [Dictionary<String, Any>]{
                
                if let weatherType = weather[0]["main"] as? String{
                    _weatherType = weatherType
                }
            }
            
            if let date = dataDic["dt"] as? Double{
                let unixConvertedDate = Date(timeIntervalSince1970: date)
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .full
                dateFormatter.dateFormat = "EEEE"
                dateFormatter.timeStyle = .none
                _date = unixConvertedDate.daysOfTheWeek()
            }
        
    }
    
}

extension Date{
    func daysOfTheWeek()->String{
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
        
    }
}




