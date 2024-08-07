//
//  WeatherModel.swift
//  AmazingWeather
//
//   Created by Sunjay Kalsi on  17/01/2021.
//

import Foundation

struct WeatherModel {
    var locationName: String = ""
    var temp: Double = 0
    var humidity: Int = 0
    var sunriseUnixUtc: Int = 0
    var sunsetUnixUtc: Int = 0
    
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
}
