//
//  ViewController.swift
//  AmazingWeather
//
//  Created by Sunjay Kalsi on 17/06/2021.
//

import UIKit

class WeatherViewController: UIViewController, ConnectionChangedDelegate {
    private let network = Network()
    private let utilities = Utilities()
    private let monitor = Utilities()
    
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
            let cities = ["London", "Paris"]
            var pos = 0
            
            for city in cities {
                network.loadWeatherData(city: city, completion: { weatherVal in
                    self.setUiWithModelData(weatherModel: weatherVal, index: pos)
                    pos += 1
                })
            }
        } else {
            let alert = UIAlertController(title: "Network Error", message: "You have lost network connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
        networkConnected = connected
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        utilities.delegate = self
        utilities.setUpNotifications()
    }
    
    func setUiWithModelData(weatherModel: WeatherModel?, index: Int) {
        guard let weatherModelUnwrapped = weatherModel else { return }

        if index == 0 {
            upperLocation.text = weatherModelUnwrapped.locationName
            upperTemp.text = String(weatherModelUnwrapped.temp)
            uppperHumidity.text = String(weatherModelUnwrapped.humidity)
            upperSunriseTime.text = String(weatherModelUnwrapped.sunriseDisplay)
            upperSunsetTime.text = String(weatherModelUnwrapped.sunsetDisplay)
        } else {
            lowerLocation.text = weatherModelUnwrapped.locationName
            lowerTemp.text = String(weatherModelUnwrapped.temp)
            lowerHumidity.text = String(weatherModelUnwrapped.humidity)
            lowerSunriseTime.text = String(weatherModelUnwrapped.sunriseDisplay)
            lowerSunsetTime.text = String(weatherModelUnwrapped.sunsetDisplay)
        }
    }
}
