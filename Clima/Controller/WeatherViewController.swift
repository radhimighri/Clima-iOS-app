//
//  ViewController.swift
//  Clima
//
//  Created by Radhi Mighri on 5/19/20.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    

    var weatherManager = WeatherManager()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//

        
        //activate the notifications for the locationManager by making the WeatherViewController class its delegate
                locationManager.delegate = self

        //triggering these functions must be after the declaration of delegate '=self" to avoid app crash
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation() // get location just one time because we don't need to follow the user movement (it's not a navigation app)

        weatherManager.delegate = self
        searchTextField.delegate = self
        
    }

    
}


// we use exetensions to split out the delegate methods of the adopted protocols from the WeatherViewController

// MARK: - UITextFieldDelegate Section

extension WeatherViewController : UITextFieldDelegate {
    
     @IBAction func searchPressed(_ sender: UIButton) {
           // print(searchTextField.text!)
            searchTextField.endEditing(true)
            
        }
        

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //        print(searchTextField.text!)
            searchTextField.endEditing(true)
            return true
        }
        

        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if textField.text != "" {
                return true
            }
            else {
                textField.placeholder = "Type something"
                return false
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            //use the searchTextField.text (before initialise it to an empty String) to get the weather for the city.
            
            if let city = searchTextField.text { //optional binding : optionally unwrap my searchTextFlield.text : now my city proprety is a proper string
                weatherManager.fetchWeather(cityName: city)
                
            }
            
            searchTextField.text = ""
        }
}

// MARK: - WeatherManagerDelegate Section

extension WeatherViewController: WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather : WeatherModel) {
//          print(weather.temperature)
        DispatchQueue.main.async { //we use the Dispatch closure because the rendring of the temperature may take along time depending to the internet speed or any another problem so our app will work normaly but the UI elements will change their proprietes when the handler completion function complete its work and render the resulat
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            
        }
          }
      
      func didFailWithError(error: Error) {
          print(error)
      }
}


// MARK: - CLLocationManagerDelegate Section

extension WeatherViewController: CLLocationManagerDelegate {

    
    @IBAction func locationPressed(_ sender: UIButton) {
    
        //So at a later point(after searching by cityName) this method "locationPressed" calls this methode "locationManager.requestLocation()"again and our locationManager(didUpdateLocations) has been activated once more so we can call this delegate method again
        locationManager.requestLocation()
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print("Got location Data")
        if let location = locations.last { //because this "locations.last" is optional we should first optionally bind it in order to use it , so that we unwraped into a new constant "location"
            locationManager.stopUpdatingLocation()//as soon as we found a the location we told the locationManager to stop searching and we use the location to get the current weather
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
//            print("Latitude : \(lat) and Longitude : \(lon)")

            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    // we have also to implement this didFailedWithError method to avoid app crash
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
