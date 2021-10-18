//
//  ViewModel.swift
//  AmazingWeather
//
//  Created by Sunjay Kalsi on 18/10/2021.
//

import Foundation

protocol WeatherModelOutput {
    func loaded()
}

struct WeatherViewModel {
    private var weatherModel: WeatherModel?
    
    init() {
        self.weatherModel = nil
    }
    
    func getWeatherData() {
        
    }
}

