//
//  Route.swift
//  AmazingWeather
//
//  Created by Sunjay Kalsi on 21/10/2021.
//

import Foundation
import Alamofire

public protocol Route {
    // Request & ResponseType are forced, but `Empty` allows you to skip encoding/decoding
    associatedtype RequestType: Encodable // associatedType is how you define generics in a protocol (abstract)
    associatedtype ResponseType: Decodable
    
    static var method: HTTPMethod { get }
    static var path: String { get }
    static var requiresAuth: Bool { get }
    
    // Optional instance of `RequestType` that gets encodewd if present
    var requestObject: RequestType? {get set}
    
    // Any query parameters
    var querytParameters: [URLQueryItem] {get set}
    
    // Any path items that we can then encode to the request string. These will be appended in the order they are found in the array
    
    func toRequst() -> URLRequest
}
