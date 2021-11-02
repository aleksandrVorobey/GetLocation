//
//  APIWeatherConstants.swift
//  Location
//
//  Created by Александр Воробей on 31.10.2021.
//

import Foundation

enum APIWeatherConstants: String {
    case baseURL = "https://api.weather.yandex.ru/v2/informers?lat"
    case apiKey = "90d6cf85-51c0-4f3e-848f-342c6e9519b4"
    case apiValue = "X-Yandex-API-Key"
    case lat = "lat="
    case lon = "&lon="
}
