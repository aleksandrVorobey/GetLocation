//
//  RequestViewController.swift
//  Location
//
//  Created by Александр Воробей on 29.10.2021.
//

import UIKit
import CoreLocation

class RequestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var locationArray = [CLLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        guard let currentPosition = LocationManager.shared.lastPosition else { return }
        locationArray.append(currentPosition)
    }
}

extension RequestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RequestTableViewCell
        let location = locationArray[indexPath.row]
        cell.configure(location: location)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locationArray[indexPath.row]
        let newVc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        newVc.configDetail(location: location)
        navigationController?.pushViewController(newVc, animated: true)
    }
    
}

