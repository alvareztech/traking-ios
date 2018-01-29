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
    @IBOutlet weak var messageLabel: UILabel!
    
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
    
        checkForLocationServices()
    }
    
    func checkForLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            // Location services are available, so query the user’s location.
            //        locationManager.startMonitoringSignificantLocationChanges()
                        locationManager.startUpdatingLocation()
        } else {
            // Update your app’s UI to show that the location is unavailable.
            messageLabel.text = "Location is unavailable"
        }
    }
    
    func enableLocationServices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            // Disable location features
            
            break
            
        case .authorizedWhenInUse:
            // Enable basic location features
//            enableMyWhenInUseFeatures()
            break
            
        case .authorizedAlways:
            // Enable any of your app's location features
//            enableMyAlwaysFeatures()
            break
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mostRecentLocation = locations.last else {
            return
        }
        
        print("mostRecent: \(mostRecentLocation.coordinate.latitude), \(mostRecentLocation.coordinate.longitude), \(mostRecentLocation.altitude), \(mostRecentLocation.timestamp)")
        
        let point = Point()
        point.latitude = mostRecentLocation.coordinate.longitude
        point.longitude = mostRecentLocation.coordinate.latitude
        point.date = mostRecentLocation.timestamp
        point.day = Util.getDay(point.date)
        point.month = Util.getMonth(point.date)
        point.year = Util.getYear(point.date)
        Database.save(point: point)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            // Disable your app's location features
            
            break
            
        case .authorizedWhenInUse:
            // Enable only your app's when-in-use features.
//            enableMyWhenInUseFeatures()
            break
            
        case .authorizedAlways:
            // Enable any of your app's location services.
//            enableMyAlwaysFeatures()
            break
            
        case .notDetermined:
            break
        }
    }
}
