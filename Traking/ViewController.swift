//
//  ViewController.swift
//  Traking
//
//  Created by Daniel Alvarez on 1/25/18.
//  Copyright © 2018 ALVAREZ.tech. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.allowsBackgroundLocationUpdates = true
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
    }

}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mostRecentLocation = locations.last else {
            return
        }
        
        print("mostRecent: \(mostRecentLocation.coordinate.latitude), \(mostRecentLocation.coordinate.longitude), \(mostRecentLocation.altitude), \(mostRecentLocation.timestamp)")
    }
    
}
