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
    
    public static func formatFromUnixUtcToPrettyTime(unixTime: Int) -> String {
        let dateTime = NSDate(timeIntervalSince1970: Double(unixTime))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: dateTime as Date)
    }
}
