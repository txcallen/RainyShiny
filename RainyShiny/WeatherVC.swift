//
//  WeatherVC.swift
//  RainyShiny
//
//  Created by Tianchong Xie on 2017-04-26.
//  Copyright © 2017 Tianchong Xie. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var currentDateLbl: UILabel!
    @IBOutlet weak var currentTemLbl: UILabel!
    @IBOutlet weak var currentLocationLbl: UILabel!
    @IBOutlet weak var weatherConImg: UIImageView!
    @IBOutlet weak var weatherConLbl: UILabel!
    @IBOutlet weak var weatherTableView: UITableView!
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecasts = [Forecast]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up the location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        //must set to self to let it work
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        
        currentWeather = CurrentWeather()
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            //save it to the variable
            currentLocation = locationManager.location
            Location.shareInstance.latitude = currentLocation.coordinate.latitude
            Location.shareInstance.longtitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetail {
                self.downloadForecastData {
                    self.updateUI()
                    
                }
            }
            print(Location.shareInstance.latitude, Location.shareInstance.longtitude)
        }else{
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    //Must implement
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //name your table view cell and come back to set the identifier like this
        //cast them to ForecastCell
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? ForecastCell{
            
            let forecast = forecasts[indexPath.row]
            cell.updateUI(forecast: forecast)
            return cell
        }else{
            return ForecastCell()
        }
        
    }

    
            //update the current weather UI
    func updateUI(){
        currentLocationLbl.text = currentWeather.cityName
        currentTemLbl.text = "\(currentWeather.currentTemp)"
        weatherConLbl.text = currentWeather.weatherType
        currentDateLbl.text = currentWeather.date
        weatherConImg.image = UIImage(named: currentWeather.weatherType)
    }
    
    
    //Download the forecast data method
    func downloadForecastData(completed: @escaping DownLoadComplete){
        Alamofire.request(FORECAST_WEATHER_URL).responseJSON{ response in
            
            let result = response.result
            if let dataDic = result.value as? Dictionary<String, Any>{
                
                if let list = dataDic["list"] as? [Dictionary<String, Any>]{
                    
                    for forecastDic in list {
                        let forecast = Forecast(dataDic: forecastDic)
                        self.forecasts.append(forecast)
                        print(forecastDic)
                    }
                    //remove the today's weather data
                    self.forecasts.remove(at: 0)
                    self.weatherTableView.reloadData()
                }
                
            }
            completed()
        }
        
    }




}

