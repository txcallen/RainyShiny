//
//  Location.swift
//  RainyShiny
//
//  Created by Tianchong Xie on 2017-04-27.
//  Copyright © 2017 Tianchong Xie. All rights reserved.
//

import CoreLocation

class Location{
    static var shareInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longtitude: Double!
    
}
