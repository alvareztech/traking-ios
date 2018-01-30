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
        manager.distanceFilter = 2
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
//                    locationManager.startMonitoringSignificantLocationChanges()
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
    
    func showMapPoints() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        let points = Database.fetchPoints(date: Date())
        
        messageLabel.text = "\(points.count) points"
        
        var lastLocation: CLLocationCoordinate2D?
        
        for point in points {
            let location = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
            print("point >> \(point.latitude), \(point.longitude)")
            
            lastLocation = location
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = Util.formatForShow(date: point.date)
            annotation.subtitle = ""
            mapView.addAnnotation(annotation)
        }
        
        let region = MKCoordinateRegion(center: lastLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        
        mapView.setRegion(region, animated: true)
    }

    @IBAction func refreshData(_ sender: UIButton) {
        showMapPoints()
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mostRecentLocation = locations.last else {
            return
        }
        
        print("mostRecent: \(mostRecentLocation.coordinate.latitude), \(mostRecentLocation.coordinate.longitude), \(mostRecentLocation.altitude), \(mostRecentLocation.timestamp)")
        
        let point = Point()
        point.latitude = mostRecentLocation.coordinate.latitude
        point.longitude = mostRecentLocation.coordinate.longitude
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
