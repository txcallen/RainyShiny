//
//  Constants.swift
//  RainyShiny
//
//  Created by Tianchong Xie on 2017-04-26.
//  Copyright © 2017 Tianchong Xie. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUTE = "lat="
let LONGTITUTE = "&lon="
let APP_ID = "&appid=c9acb06492a6bfe03c532b1230201fa4"

let FORECAST_BASE = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let FORECAST_COUNT = "&cnt=10"
let LatValue = String(Location.shareInstance.latitude)
let LongValue = String(Location.shareInstance.longtitude)


//tell function when we are complete
typealias DownLoadComplete = () -> ()

let CURRENT_WEATHER_URL: String = "\(BASE_URL)\(LATITUTE)\(LatValue)\(LONGTITUTE)\(LongValue)\(APP_ID)"
let FORECAST_WEATHER_URL: String = "\(FORECAST_BASE)\(LATITUTE)\(LatValue)\(LONGTITUTE)\(LongValue)\(FORECAST_COUNT)\(APP_ID)"
		
func kelvinToCelcius(kelvinValue: Double)-> Double{
    let kelvinCelsiusConversionConstant:Double = 273.15
    
    let rawTemp = kelvinValue - kelvinCelsiusConversionConstant
    
    let celciusTemp = Double(round(10*rawTemp/10))
    
    return celciusTemp
}
