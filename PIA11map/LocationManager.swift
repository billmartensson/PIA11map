//
//  LocationManager.swift
//  PIA11map
//
//  Created by Bill Martensson on 2022-11-21.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        if(manager.authorizationStatus == .authorizedWhenInUse) {
            manager.startUpdatingLocation()
        } else {
            print("FÅR INTE POSITION")
            manager.requestWhenInUseAuthorization()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("FAIL!")
        print(error.localizedDescription)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("Nu händer locationManagerDidChangeAuthorization")
        if(manager.authorizationStatus == .authorizedWhenInUse) {
            requestLocation()
        }
        
        if(manager.authorizationStatus == .denied){
            // Användaren sa nej
        }
    }
}
