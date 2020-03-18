//
//  DeviceManager.swift
//  BluetoothScanner
//
//  Created by Marcelo Farjalla on 3/16/20.
//  Copyright © 2020 StackRank, LLC. All rights reserved.
//

import Foundation

class DeviceManager {
  
  let bluetoothManager = BluetoothManager() 
  var devices: Observable<[Device]> = Observable<[Device]>([])
  
  init() {
   
    bluetoothManager.delegate = self
    
  }
  
  func getDevices() -> [Device] {
    return self.devices.value
  }
  
  func startScan() {
    bluetoothManager.startScan()
  }
  
  func stopScan() {
    bluetoothManager.stopScan()
  }
}

extension DeviceManager: BluetoothManagerDelegate {
  func didUpdateDevices() {
    
    self.devices.value = self.bluetoothManager.getDevices()
    
  }
}
