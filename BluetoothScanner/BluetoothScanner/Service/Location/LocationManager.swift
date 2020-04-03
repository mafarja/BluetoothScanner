//
//  LocationManager.swift
//  BluetoothScanner
//
//  Created by Marcelo Farjalla on 3/18/20.
//  Copyright © 2020 StackRank, LLC. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
  let latitude: Double
  let longitude: Double
}

class LocationManager: NSObject {
  
  private var locationManager: CLLocationManager!
  private var location: Location?
  
  override init() {
    super.init()
    
    self.locationManager = CLLocationManager()
    
    
    
  }
  
  func getLocation(_ completion: @escaping (Location?) -> Void) {
    self.locationManager.requestWhenInUseAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    
    
//    kCLLocationAccuracyNearestTenMeters
    
    while CLLocationManager.authorizationStatus() == .notDetermined {
      
      
    }
    
    guard let _location = locationManager.location,
      CLLocationManager.locationServicesEnabled()
      else {
      completion(nil)
        return
    }
    
    let latitude = _location.coordinate.latitude
    let longitude = _location.coordinate.longitude
    
    completion(Location(latitude: latitude, longitude: longitude))
  
  }

}

