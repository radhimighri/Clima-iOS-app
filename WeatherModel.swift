//
//  WeatherModel.swift
//  Clima
//
//  Created by Radhi Mighri on 5/19/20.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import Foundation

//// before using computed proprety
//struct WeatherModel {
//    let conditionId: Int
//    let cityName: String
//    let temperature: Double
//
//
//    func getConditionName(weatherId: Int) -> String {
//        switch weatherId {
//            case 200...232:
//                return "cloud.bolt"
//            case 300..<322:
//                return "cloud.drizzle"
//            case 501...531:
//                return "cloud.rain"
//            case 600...622:
//                return "cloud.snow"
//            case 701...781:
//                return "cloud.fog"
//            case 800:
//                return "sun.max"
//            case 801...804:
//                return "cloud.bolt"
//            default:
//                return "cloud"
//            }
//    }
//}

// After using computed proprety
struct WeatherModel {
    //our stored proprieties : they just used to store pieces of data
    let conditionId: Int
    let cityName: String
   let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
        
    }

    // we called computed proprety because it gonna work out and return an output value
    // here we declare our computed proprety "conditionName" and we put inside it the contenu of our old method
    var conditionName : String { //var : the value is always going to change, it's based on the computation inside its curly braces
        switch conditionId {
            case 200...232:
                return "cloud.bolt"
            case 300..<322:
                return "cloud.drizzle"
            case 501...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
            }
    }

}
