//
//  DevicesTrackedCellViewModel.swift
//  BluetoothScanner
//
//  Created by Marcelo Farjalla on 3/20/20.
//  Copyright © 2020 StackRank, LLC. All rights reserved.
//

import Foundation

class DevicesTrackedCellViewModel {
  let device: Device!
  let deviceName: String!
  let lastScannedString: String!
  
  init(device: Device) {
    self.device = device
    self.deviceName = device.name
    if let lastScannedDate = self.device.lastScanned {
      self.lastScannedString = "\(lastScannedDate.timeSinceDate(fromDate: Date()))"
    } else {
      self.lastScannedString = "unkown"
    }
  }
  
}
