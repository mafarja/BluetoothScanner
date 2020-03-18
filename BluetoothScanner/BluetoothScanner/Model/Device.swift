//
//  Device.swift
//  BluetoothScanner
//
//  Created by Marcelo Farjalla on 3/16/20.
//  Copyright © 2020 StackRank, LLC. All rights reserved.
//

import Foundation

class Device {
  let id: UUID
  let name: String
  var rssi: NSNumber
  
  init(id: UUID, name: String, rssi: NSNumber) {
    self.id = id
    self.name = name
    self.rssi = rssi
  }
}

extension Device: Equatable {
  static func == (lhs: Device, rhs: Device) -> Bool {
    return lhs.id == rhs.id
  }
  
  
}
