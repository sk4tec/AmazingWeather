//
//  Network.swift
//  AmazingWeather
//
//  Created by Sunjay Kalsi on 17/01/2021.
//

import Foundation
import Alamofire
import SwiftyJSON
//https://openweathermap.org/current
struct Network {
    private let weatherApiKey = "062487fc4b8c1f4cf2c6e584511b54ef"
    private let apiBaseURL = "https://api.openweathermap.org/data/2.5/weather?q="
    private let measurementUnits = "&units=metric"
    
    func loadWeatherForCities(cites: [String]) -> [WeatherModel]{
        var cityWeathers = [WeatherModel]()
        
        for city in cites {
            self.loadWeatherData(city: city, completion: { weatherVal in
                if let weatherVal = weatherVal {
                    cityWeathers.append(weatherVal)
                }
            })
        }
        return cityWeathers
    }
    
    
    func loadWeatherData(city: String, completion: @escaping (WeatherModel?) -> Void) {
        let completeUrl = apiBaseURL + city + "&appid=" + weatherApiKey + measurementUnits
        
        var weatherModel: WeatherModel? = nil
        
        AF.request(completeUrl).responseJSON { response in
            switch response.result {
            case .success(let value):
                //decode the whole object
                //let weatherData = try? JSONDecoder().decode(WeatherData.self, from: response.data!)
                
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: response.data!)
                    print(weatherData)
                } catch  {
                    print("error")
                }
                
                let json = JSON(value)
                weatherModel = WeatherModel()
                weatherModel?.locationName = city
                weatherModel?.temp = json["main"]["temp"].number?.intValue ?? 0
                weatherModel?.humidity = json["main"]["humidity"].number?.intValue ?? 0
                weatherModel?.sunriseUnixUtc = json["sys"]["sunrise"].number?.intValue ?? 0
                weatherModel?.sunsetUnixUtc = json["sys"]["sunset"].number?.intValue ?? 0
                
                completion(weatherModel)
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
}
