//
//  WeatherManager.swift
//  Clima
//
//  Created by Yesbolat Syilybay on 06.09.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
	func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
	func didFailWithError(error: Error)
}

struct WeatherManager {
	let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=f650eb4595ca827442a02a9a24a0855c&units=metric"
	
	var delegate: WeatherManagerDelegate?
	
	func fetchWeather(cityName: String) {
		let url = "\(weatherUrl)&q=\(cityName)"
		performRequest(with: url)
	}
	
	func fetchWeather(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) {
		let url = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude)"
		performRequest(with: url)
	}
	
	func performRequest(with urlString: String) {
		if let url = URL(string: urlString) {
			let session = URLSession(configuration: .default)
			let task = session.dataTask(with: url) { (data, response, error) in
				if error != nil {
					self.delegate?.didFailWithError(error: error!)
					return
				}
				
				if let safeData = data {
					DispatchQueue.main.async {
						if let weather = self.parseJSON(safeData) {
							self.delegate?.didUpdateWeather(self, weather: weather)
						}
					}
				}
			}

			task.resume()
		}
	}
	
	func parseJSON(_ weatherData: Data) -> WeatherModel? {
		let decoder = JSONDecoder()
		
		do {
			let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
			let weather = WeatherModel(conditionId: decodedData.weather[0].id, cityName: decodedData.name, temperature: decodedData.main.temp)
			return weather
		} catch {
			delegate?.didFailWithError(error: error)
			return nil
		}
	}
}
