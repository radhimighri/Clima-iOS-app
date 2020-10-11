//
//  WeatherManager.swift
//  Clima
//
//  Created by Radhi Mighri on 5/19/20.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import Foundation
import CoreLocation


protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error : Error)
    
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a3fcddf8498bea847df81a1d8bbd45bc&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
              let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
              performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) { //here we're going to carry out those 4 steps of networking
        
        //1. Create a URL
        
        if let url = URL(string: urlString) { //optionally bind(unwarp) the URL taht's created to a contant called "url" as long as this "URL(string: urlString)" doesn't fail and doesn't end up being nil
            
            
            
            //2. Create a URLSession
            
            let session = URLSession(configuration: .default) // this ends up creating our urlSession object wich is like our browser and it's the thing that can perform the networking
            
            //3. Give the session a task
            
            // without closure use
            //  let task = session.dataTask(with: url, completionHandler: handle(data:response:error:)) // Creates a task that retrieves the contents of the specified URL, then calls a handler or method upon completion (onece it completes executing the task and bring the data , beacause it can take a time depending to your network speed)
            
            //After converting our completionHandler to an actual swift closure : type let task = session.dataTask( and chose like before and then with tab button move to the completionHandler ,it will become blue then hit enter (vid 10) : it will be format it into a trailing closure automatically, then we can add the names of our inputs and now after the "in" keyword we're going to move everything that used to live in our handle() method and now it's going to go inside our closure and we can delete the seperate method "handle()"
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return // exit this function
                }
                
                if let safeData = data {
//                  let dataString = String(data: safeData, encoding: .utf8) // before using parsing
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            //4 Start the task
            task.resume()
            
            
        }
        
    }
    
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder() // this is the object that can decode JSON
        
        do{
        
         let decodedData =   try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
//            print(weather.conditionName)
//            print(weather.temperatureString)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
        
        }
    
    
    // without closure use
    //    func handle(data:Data?, response: URLResponse?, error: Error?){
    //        if error != nil {
    //            print(error!)
    //            return // exit this function
    //        }
    //
    //        if let safeData = data {
    //            let dataString = String(data: safeData, encoding: .utf8)
    //            print(dataString!)
    //        }
    //
    //        if let res = response {
    //            print(res)
    //        }
    //    }
    

    
}
