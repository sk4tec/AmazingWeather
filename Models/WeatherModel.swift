//
//  WeatherModel.swift
//  AmazingWeather
//
//  Created by Sunjay Kalsi on 19/06/2021.
//

import Foundation

struct WeatherModel {
    let locationName: String
    let temp: Int
    let humidity: Int
    let sunriseUnixUtc: Int
    let sunsetUnixUtc: Int
    
    var sunriseDisplay: String {
        get {
            return  Utilities.formatFromUnixUtcToPrettyTime(unixTime: sunriseUnixUtc)
        }
    }

    var sunsetDisplay: String {
        get {
            return Utilities.formatFromUnixUtcToPrettyTime(unixTime: sunsetUnixUtc)
        }
    }
    
    init(locationName: String, temp: Int, humidity: Int, Sunrise: Int, Sunset: Int) {
        self.locationName = locationName
        self.temp = temp
        self.humidity = humidity
        self.sunriseUnixUtc = Sunrise
        self.sunsetUnixUtc = Sunset
    }
}
