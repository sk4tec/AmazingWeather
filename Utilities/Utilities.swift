//
//  Utilities.swift
//  AmazingWeather
//
//  Created by Sunjay Kalsi on 18/06/2021.
//

import Foundation
import Network

protocol ConnectionChangedDelegate {
    func connectionChanged(connected: Bool)
}

//This contains the helper functions the app needs, perhaps if it grew then other more specific classes can be created
class Utilities {
    private let monitor = NWPathMonitor()
    public var delegate: ConnectionChangedDelegate?
    
    func setUpNotifications () {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                debugPrint("Connected!")
                self.delegate?.connectionChanged(connected: true)
            } else {
                debugPrint("No connection.")
                self.delegate?.connectionChanged(connected: false)
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        self.monitor.start(queue: queue)
    }
    
    //I started out with this func in the ViewModel, but I ended up putting it here. It makes more sense here. One of the benifits is that it's more testable here
    public static func formatFromUnixUtcToPrettyTime(unixTime: Int) -> String {
        let dateTime = NSDate(timeIntervalSince1970: Double(unixTime))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: dateTime as Date)
    }
}
