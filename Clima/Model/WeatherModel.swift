//
//  WeatherModel.swift
//  Clima
//
//  Created by Yesbolat Syilybay on 07.09.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
	let conditionId: Int
	let cityName: String
	let temperature: Double
	
	var temperatureString: String {
		return String(Int(temperature))
	}
	
	var conditionName: String {
		switch conditionId {
		case 200...201:
			return "cloud.bolt.rain"
		case 202:
			return "cloud.bolt.rain.fill"
		case 210...211:
			return "cloud.bolt"
		case 212:
			return "cloud.bolt.fill"
		case 221:
			return "cloud.bolt"
		case 230...232:
			return "cloud.bolt.rain"
		case 300...311:
			return "cloud.drizzle"
		case 312...321:
			return "cloud.drizzle.fill"
		case 500...501:
			return "cloud.sun.rain"
		case 502...504:
			return "cloud.sun.rain.fill"
		case 511:
			return "cloud.sleet"
		case 520:
			return "cloud.heavyrain"
		case 521:
			return "cloud.rain.fill"
		case 522:
			return "cloud.heavyrain.fill"
		case 531:
			return "cloud.rain"
		case 600...602:
			return "cloud.snow"
		case 611...612:
			return "cloud.sleet"
		case 613...616:
			return "cloud.sleet.fill"
		case 620...622:
			return "cloud.snow.fill"
		case 701:
			return "smoke"
		case 711:
			return "smoke.fill"
		case 721:
			return "sun.haze"
		case 731:
			return "sun.dust"
		case 741:
			return "cloud.fog"
		case 751:
			return "sun.dust"
		case 761...762:
			return "sun.dust.fill"
		case 771:
			return "wind"
		case 781:
			return "tornado"
		case 800:
			return "sun.max"
		case 801:
			return "cloud.sun"
		case 802:
			return "cloud"
		case 803...804:
			return "cloud.fill"
		default:
			print("Unknown weather-code")
			return ""
		}
	}
}
