//
//  WeatherData.swift
//  Clima
//
//  Created by Radhi Mighri on 5/19/20.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import Foundation

//struct WeatherData: Decodable, Encodable { // Decodable : by adopting this protocol that's means that the weatherData turned into a type that can decode itself from an external representation namely the JSON representation to a String format
//    //Encodable : allows your swift objects to be encouded into a JSON Format
//    let name: String
//    let main : Main
//    let weather: [Weather]
//}
//
//struct Main : Decodable, Encodable{
//    let temp: Double
//
//}
//
//struct Weather : Decodable, Encodable {
//    let description : String
//    let id : Int
//
//}

//After using a Typealias
struct WeatherData: Codable { // Decodable : by adopting this protocol that's means that the weatherData turned into a type that can decode itself from an external representation namely the JSON representation to a String format
    //Encodable : allows your swift objects to be encouded into a JSON Format
    let name: String
    let main : Main
    let weather: [Weather]
}

struct Main: Codable{
    let temp: Double
    
}

struct Weather: Codable  {
    let description : String
    let id : Int
    
}
