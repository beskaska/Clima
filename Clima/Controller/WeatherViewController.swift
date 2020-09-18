//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
	
	var weatherManager = WeatherManager()
	var locationManager = CLLocationManager()
	
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var searchTextField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
		
		searchTextField.delegate = self
		weatherManager.delegate = self
    }
	
	@IBAction func currentLocationPressed(_ sender: UIButton) {
		locationManager.startUpdatingLocation()
	}
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
	@IBAction func searchPressed(_ sender: UIButton) {
		searchTextField.endEditing(true)
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		searchTextField.endEditing(true)
		return true
	}
	
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		if textField.text != "" {
			textField.placeholder = "Search"
			return true
		} else {
			textField.placeholder = "Type something"
			return false
		}
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		if let city = textField.text {
			weatherManager.fetchWeather(cityName: city)
		}
		textField.text = ""
	}
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
	func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
		cityLabel.text = weather.cityName
		temperatureLabel.text = weather.temperatureString
		conditionImageView.image = UIImage(systemName: weather.conditionName)
	}
	
	func didFailWithError(error: Error) {
		print(error)
	}
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.last {
			locationManager.stopUpdatingLocation()
			let latitude = location.coordinate.latitude
			let longitude = location.coordinate.longitude
			weatherManager.fetchWeather(latitude, longitude)
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print(error)
    }
}
