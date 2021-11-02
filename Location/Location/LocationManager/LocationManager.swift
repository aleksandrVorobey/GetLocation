//
//  LocationManager.swift
//  Location
//
//  Created by Александр Воробей on 27.10.2021.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    private override init() {}
    
    let manager = CLLocationManager()
    var lastPosition: CLLocation?
    
    //MARK: - GetUserLocation
    func getUserLocation() {
        manager.delegate = self
        guard CLLocationManager.locationServicesEnabled() else {
            print("Allow location alert")
            return }
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.lastPosition = location
        manager.stopUpdatingLocation()
    }
    
    //MARK: - Geocoding
    func geocodeLocationName(with location: CLLocation?, completion: @escaping (String) -> ()) {
        guard let location = location else {
            print("Location nil")
            return }
        CLGeocoder().reverseGeocodeLocation(location, preferredLocale: .current) { placemarks, error in
            guard let place = placemarks?.first, error == nil else { return }
            let nameLocality = "\(place.locality ?? "City nil")"
            completion(nameLocality)
        }
    }
    
    //MARK: - StatusAuthorization
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        switch status {
        case .authorizedAlways: print("authorizedAlways")
            manager.startUpdatingLocation()
        case .authorizedWhenInUse: print("authorizedWhenInUse")
            manager.startUpdatingLocation()
        case .denied: print("denied")
        case .notDetermined: print("notDetermined")
        case .restricted: print("restricted")
        default:
            print("unknow")
        }
    }
}
