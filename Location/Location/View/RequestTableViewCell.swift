//
//  RequestTableViewCell.swift
//  Location
//
//  Created by Александр Воробей on 29.10.2021.
//

import UIKit
import CoreLocation

class RequestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var coordinateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(location: CLLocation) {
        self.dateTimeLabel.text = "Location received: \(location.timestamp)"
        self.coordinateLabel.text = "Location latitude: \(location.coordinate.latitude), Location longitude: \(location.coordinate.longitude)"
        
        LocationManager.shared.geocodeLocationName(with: location, completion: { city in
            self.cityLabel.text = "City: \(city)"
        })
    }
    
}
