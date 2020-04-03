//
//  DeviceScannerViewModel.swift
//  BluetoothScanner
//
//  Created by Marcelo Farjalla on 3/16/20.
//  Copyright © 2020 StackRank, LLC. All rights reserved.
//

import Foundation

class DeviceScannerViewModel {
  let deviceManager = DeviceManager.shared
  var deviceScannerCellViewModels: Observable<[DeviceScannerCellViewModel]> = Observable<[DeviceScannerCellViewModel]>([])
  
  init() {
    registerModelObservers()
  }
  
  private func registerModelObservers() {
  
    self.deviceManager.scannedDevices.addObserver(self, options: [.initial, .new]) { devices, change in
      
      self.loadDeviceViewModels(devices: devices)
      
    }
    
    
    
    
    
  }
  
  private func loadDeviceViewModels(devices: [Device]) {
    
    var deviceViewModelsArr: [DeviceScannerCellViewModel] = []
    var unknownArr: [DeviceScannerCellViewModel] = []
    for device in devices {
      if device.name == "unknown" {
        unknownArr.append(DeviceScannerCellViewModel(device: device))
        continue
      }
      deviceViewModelsArr.append(DeviceScannerCellViewModel(device: device))
    }
    deviceViewModelsArr.append(contentsOf: unknownArr)
    self.deviceScannerCellViewModels.value = deviceViewModelsArr
    
  }
  
  func startScan() {
    deviceManager.startScan()
  }
  
  func stopScan() {
    deviceManager.stopScan()
  }
  
  
  
}
