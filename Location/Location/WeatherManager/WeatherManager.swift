//
//  WeatherManager.swift
//  Location
//
//  Created by Александр Воробей on 28.10.2021.
//

import Foundation
import CoreLocation

class WeatherManager {
    static let shared = WeatherManager()
    
    func fetchWeather(lat: String?, lon: String?, completion: @escaping (Result<Weather, Error>) -> ()) {
        guard let lat = lat, let lon = lon else { return }
        
        let urlString = APIWeatherConstants.baseURL.rawValue + APIWeatherConstants.lat.rawValue + "\(lat)" + APIWeatherConstants.lon.rawValue + "\(lon)"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue(APIWeatherConstants.apiKey.rawValue, forHTTPHeaderField: APIWeatherConstants.apiValue.rawValue)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("Data task error\(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let weatherData = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(weatherData))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
