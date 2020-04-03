//
//  DeviceViewModel.swift
//  BluetoothScanner
//
//  Created by Marcelo Farjalla on 3/16/20.
//  Copyright © 2020 StackRank, LLC. All rights reserved.
//

import Foundation

class DeviceScannerCellViewModel {
  let device: Device!
  let name: String
  var rssi: Int?
  var isTracking: Bool
  var distance: Double? {
    guard let rssi = self.rssi else { return nil }
    return calculateDistance(rssi: rssi)
  }
  var distanceString: String {
    var string = "Cannot calculate distance."
    if let distance = self.distance {
      
      if distance.isLessThanOrEqualTo(1.0) {
        string = "0 - 1 meter"
      }
      if !distance.isLess(than: 1.0) && distance.isLess(than: 5.0) {
        string = "1 - 5 meters"
      }
      if !distance.isLess(than: 5.0) && distance.isLess(than: 10.0) {
        string = "5 - 10 meters"
      }
      if !distance.isLess(than: 10.0) {
        string = "10+ meters"
      }
     
    }
    return string
  }
  
  init(device: Device) {
    self.device = device
    self.name = device.name
    if let rssi = device.rssi {
      self.rssi = rssi
    }
    self.isTracking = device.isTracking
  }
  
  func toggleIsTracking() {
    
    if self.isTracking {
      self.device.stopTracking()
      self.isTracking = false
      
    } else {
      self.device.startTracking() { error in
        guard error == nil else { return }
        self.isTracking = true
      }
    }
    
  }
  
  func calculateDistance(rssi: Int) -> Double {
    var txPower = -59
    
    if (rssi == 0) {
      return -1.0
    }
    
    var ratio = (Double(rssi) * 1.0) / Double(txPower)
    if (ratio < 1.0) {
      return pow(ratio, 10)
    } else {
      var disatance = (0.89976) * pow(ratio, 7.7095) + 0.111
      return disatance
    }
  }
  

  
}
