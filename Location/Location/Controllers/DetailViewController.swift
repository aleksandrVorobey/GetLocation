//
//  DetailViewController.swift
//  Location
//
//  Created by Александр Воробей on 01.11.2021.
//

import UIKit
import CoreLocation

class DetailViewController: UIViewController {

    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var coordinateLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func configDetail(location: CLLocation?) {
        guard let location = location else { return }
        DispatchQueue.main.async {
            self.dateTimeLabel.text = "Date: \(location.timestamp)"
            
            LocationManager.shared.geocodeLocationName(with: location, completion: { city in
                self.cityLabel.text = "City: \(city)"
                
                self.coordinateLabel.text = "\(location.coordinate)"
            })
        }
        
    }
    

}
