//
//  Network.swift
//  AmazingWeather
//
//  Created by Sunjay Kalsi on 17/01/2021.
//

import Foundation
import Alamofire

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
    
    // https://openweathermap.org/current
    func loadWeatherData(city: String, completion: @escaping (WeatherModel?) -> Void) {
        let completeUrl = apiBaseURL + city + "&appid=" + weatherApiKey + measurementUnits
        
        var weatherModel: WeatherModel? = nil
        
        AF.request(completeUrl).responseJSON { response in
            switch response.result {
            case .success:

                let weatherData = try? JSONDecoder().decode(WeatherData.self, from: response.data!)
                
                weatherModel = WeatherModel()
                weatherModel?.locationName = weatherData?.name ?? ""
                weatherModel?.temp = weatherData?.main?.temp ?? 0
                weatherModel?.humidity = weatherData?.main?.humidity ?? 0
                weatherModel?.sunriseUnixUtc = weatherData?.sys?.sunrise ?? 0
                weatherModel?.sunsetUnixUtc = weatherData?.sys?.sunset ?? 0
                
                completion(weatherModel)
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
}
