//
//  DeviceScannerViewModel.swift
//  BluetoothScanner
//
//  Created by Marcelo Farjalla on 3/16/20.
//  Copyright © 2020 StackRank, LLC. All rights reserved.
//

import Foundation

class DeviceScannerViewModel {
  let deviceManager = DeviceManager()
  var deviceViewModels: Observable<[DeviceViewModel]> = Observable<[DeviceViewModel]>([])
  
  init() {
    registerModelObservers()
  }
  
  private func registerModelObservers() {
    self.deviceManager.devices.addObserver(self, options: [.initial, .new]) { devices, change in
      
      self.loadDeviceViewModels(devices: devices)
      
    }
  }
  
  private func loadDeviceViewModels(devices: [Device]) {
    
    var deviceViewModelsArr: [DeviceViewModel] = []
    for device in devices {
      deviceViewModelsArr.append(DeviceViewModel(device: device))
    }
    
    self.deviceViewModels.value = deviceViewModelsArr
    
  }
  
  func startScan() {
    deviceManager.startScan()
  }
  
  func stopScan() {
    deviceManager.stopScan()
  }
  
}
