//
//  BluetoothManager.swift
//  BluetoothScanner
//
//  Created by Marcelo Farjalla on 3/16/20.
//  Copyright © 2020 StackRank, LLC. All rights reserved.
//

import Foundation
import CoreBluetooth


struct Peripheral: Equatable {
  let peripheral: CBPeripheral
  let rssi: NSNumber
  
  static func == (lhs: Peripheral, rhs: Peripheral) -> Bool {
    return lhs.peripheral.identifier == rhs.peripheral.identifier
  }
}

protocol BluetoothManagerDelegate {
  func didUpdateDevices()
}

class BluetoothManager: NSObject {
  
  var centralManager: CBCentralManager!
  var peripherals: [Peripheral] = []
  
  var delegate: BluetoothManagerDelegate?
  
  override init() {
    super.init()
    
    centralManager = CBCentralManager(delegate: self, queue: nil)
    
  }
  
  func startScan() {
    peripherals = []
    centralManager.scanForPeripherals(withServices: nil, options: nil)
  }
  
  func stopScan() {
    centralManager.stopScan()
  }
  
  func getDevices() -> [Device] {
    
    var devices: [Device] = []
    
    for peripheral in peripherals {
      devices.append(Device(id: peripheral.peripheral.identifier, name: peripheral.peripheral.name ?? "unknown", rssi: peripheral.rssi))
    }
    
    return devices
  }
  
}

extension BluetoothManager: CBCentralManagerDelegate {
  
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    
    switch central.state {
    case .unknown:
      print("central.state is .unknown")
    case .resetting:
      print("central.state is .resetting")
    case .unsupported:
      print("central.state is .unsupported")
    case .unauthorized:
      print("central.state is .unauthorized")
    case .poweredOff:
      print("central.state is .poweroff")
    case .poweredOn:
      print("central.state is .poweredOn")
    centralManager.scanForPeripherals(withServices: nil)
    }
  }
  
  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
    
    print(peripheral)
    print(advertisementData)
    print(RSSI)
    
    
    let _peripheral = Peripheral(peripheral: peripheral, rssi: RSSI)
    
    if self.peripherals.contains(_peripheral) {
      return
    } else {
      self.peripherals.append(_peripheral)
      //centralManager.connect(_peripheral.peripheral, options: nil)
      self.delegate?.didUpdateDevices()
    }
    
  }
  
  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    print("did connect \(peripheral)")
  }
  
}



