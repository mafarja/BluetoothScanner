//
//  Device.swift
//  BluetoothScanner
//
//  Created by Marcelo Farjalla on 3/16/20.
//  Copyright © 2020 StackRank, LLC. All rights reserved.
//

import Foundation


class Device {
  let locationManager = LocationManager()
  var repository = DeviceRepository()
  
  let id: UUID
  let name: String
  var givenName: String?
  var rssi: Int?
  var location: Location?
  var isTracking: Bool = false
  var user_id: String?
  var lastScanned: Date?
  
  init(id: UUID, name: String, rssi: Int?, isTracking: Bool?, givenName: String?, location: Location?, user_id: String?) {
    self.id = id
    self.name = name
    self.rssi = rssi
    self.givenName = givenName
    self.location = location
    if let isTracking = isTracking {
      self.isTracking = isTracking
    }
    self.user_id = user_id
  }
  
 

  func startTracking(_ completion: @escaping (Error?) -> Void) {

    
    self.getLocation() { error in
      
      guard error == nil else {
        completion(error)
        return
      }
      
      self.getUserId { error in
        guard error == nil else {
          completion(error)
          return
        }
        self.isTracking = true
        
        self.repository.create(a: self)
        
        completion(nil)
      }
    }
  }
  
  func stopTracking() {
    self.isTracking = false
  
  }
  
  private func getLocation(_ completion: @escaping (Error?) -> Void) {
    locationManager.getLocation { (location) in
      if let location = location {
        self.location = location
        completion(nil)
      } else {
        AlertManager.queue(alert: Alert(title: "Location Needed", message: "Please enable location services under Settings > Privacy so the app can help you locate your bluetooth devices."))
        completion(NSError(domain: "Could not get location.", code: 0, userInfo: nil))
      }
      
    }
  }
  
  private func getUserId(_ completion: @escaping (Error?) -> Void) {
    User().getUserId { (user_id, error) in
      
      guard let user_id = user_id,
        error == nil else {
          completion(error)
          return
      }
      
      self.user_id = user_id
      
      completion(nil)
    }
  }
}

extension Device: Equatable {
  static func == (lhs: Device, rhs: Device) -> Bool {
    return lhs.id == rhs.id
  }
}
