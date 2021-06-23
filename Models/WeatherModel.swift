//
//  WeatherModel.swift
//  AmazingWeather
//
//  Created by Sunjay Kalsi on 19/06/2021.
//

import Foundation

// This is a ViewModel of the data we need to display. This is an abstraction of the CoreData version of this class (not written) - being a VM class its more geared to suit
// the UI and being presentable. Given time I'd write a layer that abstracts the CoreData version of this class behind a Facade. The Facade would handle CRUD operations of
// the CoreData class and also transform it into a ViewModel when being called from a ViewController.

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
