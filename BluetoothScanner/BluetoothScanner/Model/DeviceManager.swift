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
  let locationManager = LocationManager()
  let repository = DeviceRepository()
  
  var scannedDevices: Observable<[Device]> = Observable<[Device]>([])
  var trackedDevices: Observable<[Device]> = Observable<[Device]>([])
  
  static let shared = DeviceManager()
  
  private init() {
    bluetoothManager.delegate = self
  }
  
  func getTrackedDevices() {
    self.trackedDevices.value = self.repository.getAll()
  }
  
  func startScan() {
    bluetoothManager.startScan()
  }
  
  func stopScan() {
    bluetoothManager.stopScan()
  }
  
  func loadScannedDevices(devices: [Device]) {
    self.getTrackedDevices()
    let trackedDevices = self.trackedDevices.value
    let scannedDevices = devices
    
    for device in scannedDevices {
      if trackedDevices.contains(device) {
        device.isTracking = true
        updateDeviceLocation(device: device)
      }
    }
    
    self.scannedDevices.value = scannedDevices
    
  }
  
  private func updateDeviceLocation(device: Device) {
    
    self.locationManager.getLocation { (location) in
      guard let location = location else { return }
      device.location = location
      device.lastScanned = Date()
      self.repository.update(a: device)
    }
  }
  
  func delete(device: Device) {
    self.repository.delete(a: device)
    self.getTrackedDevices()
  }
  
}

extension DeviceManager: BluetoothManagerDelegate {
  func didUpdateDevices() {
    
    self.loadScannedDevices(devices: self.bluetoothManager.getDevices())
    
  }
}

