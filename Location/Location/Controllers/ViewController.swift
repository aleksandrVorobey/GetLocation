//
//  ViewController.swift
//  Location
//
//  Created by Александр Воробей on 26.10.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var curentCoordinateLabel: UILabel!
    @IBOutlet weak var curentPlaceLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
                
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.getUserLocation()
    }

    //MARK: - Get place label
    @IBAction func placeButtonTaped(_ sender: Any) {
        guard let currentPosition = LocationManager.shared.lastPosition else { return }
        DispatchQueue.main.async {
        self.curentCoordinateLabel.text = "\(currentPosition.coordinate) and time: \(currentPosition.timestamp)"
        }
        LocationManager.shared.geocodeLocationName(with: currentPosition) { city in
                DispatchQueue.main.async {
                    self.curentPlaceLabel.text = city
                }
        }
    }
    
    //MARK:- Get weather label
    @IBAction func weatherButtonTaped(_ sender: Any) {
        guard let currentPosition = LocationManager.shared.lastPosition else { return }
        WeatherManager.shared.fetchWeather(lat: "\(currentPosition.coordinate.latitude)", lon: "\(currentPosition.coordinate.longitude)") { result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.conditionLabel.text = weather.fact.condition
                    self.tempLabel.text = "\(weather.fact.temp)"
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
