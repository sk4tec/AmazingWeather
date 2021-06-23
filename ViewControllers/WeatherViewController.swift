//
//  ViewController.swift
//  AmazingWeather
//
//  Created by Sunjay Kalsi on 17/06/2021.
//

import UIKit
import Alamofire
import SwiftyJSON

enum City: String {
    case London = "London"
    case Paris = "Paris"
}

enum Uilocation {
    case Upper
    case Lower
}

let weatherApiKey = "062487fc4b8c1f4cf2c6e584511b54ef"
let apiBaseURL = "https://api.openweathermap.org/data/2.5/weather?q="
let measurementUnits = "&units=metric" //this should come from the locale settings, but I'm fixing it to metric

class WeatherViewController: UIViewController, ConnectionChangedDelegate {
    private let utilities = Utilities()
    private var weatherModelUpper: WeatherModel? = nil //View for upper model
    private var weatherModelLower: WeatherModel? = nil //View for lower model
    private var networkConnected = false
    
    @IBOutlet weak var upperLocation: UILabel!
    @IBOutlet weak var upperTemp: UILabel!
    @IBOutlet weak var uppperHumidity: UILabel!
    @IBOutlet weak var upperSunriseTime: UILabel!
    @IBOutlet weak var upperSunsetTime: UILabel!
    
    @IBOutlet weak var lowerLocation: UILabel!
    @IBOutlet weak var lowerTemp: UILabel!
    @IBOutlet weak var lowerHumidity: UILabel!
    @IBOutlet weak var lowerSunriseTime: UILabel!
    @IBOutlet weak var lowerSunsetTime: UILabel!
    
    func connectionChanged(connected: Bool) {
        if connected {
            loadWeatherData(city: .London, completion: { weatherVal in
                self.setUiWithModelData(weatherModel: weatherVal, location: .Upper)
            })
            loadWeatherData(city: .Paris, completion: { weatherVal in
                self.setUiWithModelData(weatherModel: weatherVal, location: .Lower)
            })
        } else {
            //In the absense of CoreData show a user message.
            let alert = UIAlertController(title: "Network Error", message: "You have lost network connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
        networkConnected = connected
    }
    
    let monitor = Utilities()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        utilities.delegate = self
        utilities.setUpNotifications()
    }

    func setUiWithModelData(weatherModel: WeatherModel?, location: Uilocation) {
        guard let weatherModelUnwrapped = weatherModel else { return }

        switch location {
        case .Upper:
            upperLocation.text = weatherModelUnwrapped.locationName
            upperTemp.text = String(weatherModelUnwrapped.temp)
            uppperHumidity.text = String(weatherModelUnwrapped.humidity)
            upperSunriseTime.text = String(weatherModelUnwrapped.sunriseDisplay)
            upperSunsetTime.text = String(weatherModelUnwrapped.sunsetDisplay)
        case .Lower:
            lowerLocation.text = weatherModelUnwrapped.locationName
            lowerTemp.text = String(weatherModelUnwrapped.temp)
            lowerHumidity.text = String(weatherModelUnwrapped.humidity)
            lowerSunriseTime.text = String(weatherModelUnwrapped.sunriseDisplay)
            lowerSunsetTime.text = String(weatherModelUnwrapped.sunsetDisplay)
        }
    }
    
    func loadWeatherData(city: City, completion: @escaping (WeatherModel?) -> Void) {
        let completeUrl = apiBaseURL + city.rawValue + "&appid=" + weatherApiKey + measurementUnits
        
        var weatherModel: WeatherModel? = nil
        
        AF.request(completeUrl).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                weatherModel = WeatherModel(locationName: city.rawValue,
                                                 temp: json["main"]["temp"].number?.intValue ?? 0,
                                                 humidity: json["main"]["humidity"].number?.intValue ?? 0,
                                                 Sunrise: json["sys"]["sunrise"].number?.intValue ?? 0,
                                                 Sunset: json["sys"]["sunset"].number?.intValue ?? 0)
                
                completion(weatherModel)
            case .failure(let error):
                print(error)
                completion(nil)
                // we need to load old data from the DB, if we have any?
            }
        }
    }
}
