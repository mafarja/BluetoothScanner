//
//  DeviceViewModel.swift
//  BluetoothScanner
//
//  Created by Marcelo Farjalla on 3/16/20.
//  Copyright © 2020 StackRank, LLC. All rights reserved.
//

import Foundation

class DeviceViewModel {
  let device: Device!
  let name: String
  let rssi: NSNumber
  
  init(device: Device) {
    self.device = device
    self.name = device.name
    self.rssi = device.rssi
  }
  
}
