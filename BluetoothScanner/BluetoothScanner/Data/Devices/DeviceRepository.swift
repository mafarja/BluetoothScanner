//
//  DeviceRepository.swift
//  BluetoothScanner
//
//  Created by Marcelo Farjalla on 3/18/20.
//  Copyright © 2020 StackRank, LLC. All rights reserved.
//

import Foundation
import CoreData

class DeviceRepository: Repository {
  
  let coreDataManager = CoreDataManager()
  
  func getAll() -> [Device] {
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Device")
    
    let devices_MO = (try? CoreDataManager.backgroundContext.fetch(fetchRequest)) as! [Device_ManagedObject]
    
    var devices: [Device] = []
    
    for device_MO in devices_MO {
      var device = Device(id: device_MO.id,
                          name: device_MO.name,
                          rssi: nil, isTracking: device_MO.isTracking, givenName: device_MO.givenName, location: Location(latitude: device_MO.latitude, longitude: device_MO.longitude), user_id: device_MO.user_id)
      if let lastScanned = device_MO.lastScanned {
        device.lastScanned = lastScanned
      }
    
      devices.append(device)
      
    }
    
    return devices
    
  }
  
  func get(identifier: Int) -> Device? {
    return Device(id: UUID(uuidString: "68847190-2FD3-8936-66C0-CB6D182176E7")!, name: "123f", rssi: 123, isTracking: nil, givenName: nil, location: nil, user_id: nil)
  }
  
  func create(a: Device) -> Bool {
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Device")
    fetchRequest.predicate = NSPredicate(format: "id == %@", a.id as CVarArg)
    
    let device_ManagedObjectArr = (try? CoreDataManager.backgroundContext.fetch(fetchRequest)) as! [Device_ManagedObject]
    
    if (device_ManagedObjectArr.count > 0) {
      return false
    }
    
    
    let device_ManagedObject = NSEntityDescription.insertNewObject(forEntityName: "Device", into: CoreDataManager.backgroundContext) as! Device_ManagedObject
    
    device_ManagedObject.setValue(a.id, forKey: "id")
    device_ManagedObject.setValue(a.isTracking, forKey: "isTracking")
    device_ManagedObject.setValue(a.location?.latitude, forKey: "latitude")
    device_ManagedObject.setValue(a.location?.longitude, forKey: "longitude")
    device_ManagedObject.setValue(a.name, forKey: "name")
    device_ManagedObject.setValue(a.givenName, forKey: "givenName")
    
    self.save()
    
    return true
  }
  
  func update(a: Device) -> Bool {
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Device")
    fetchRequest.predicate = NSPredicate(format: "id == %@", a.id as CVarArg)
    let device_ManagedObjectArr = (try? CoreDataManager.backgroundContext.fetch(fetchRequest)) as! [Device_ManagedObject]
    
    if device_ManagedObjectArr.count == 0 { return false }
    
    let device_ManagedObject = device_ManagedObjectArr[0]
    
    if let location = a.location {
      
      device_ManagedObject.setValue(location.latitude, forKey: "latitude")
      device_ManagedObject.setValue(location.longitude, forKey: "longitude")
    }
    
    if let lastScanned = a.lastScanned {
      device_ManagedObject.setValue(lastScanned, forKey: "lastScanned")
    }
    
    self.save()
    
    
    return true
  }
  
  func delete(a: Device) -> Bool {
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Device")
    fetchRequest.predicate = NSPredicate(format: "id == %@", a.id as CVarArg)
    
    let device_ManagedObjectArr = (try? CoreDataManager.backgroundContext.fetch(fetchRequest)) as! [Device_ManagedObject]
    
    if device_ManagedObjectArr.count == 0 { return false }
    let device_managedObject = device_ManagedObjectArr[0]
    CoreDataManager.backgroundContext.delete(device_managedObject)
    self.save()
    
    return true
  }
  
  private func save() {
    if CoreDataManager.backgroundContext.hasChanges {
      do {
        try CoreDataManager.backgroundContext.save()

        
      } catch let error {
        print("Error saving context \(error)")
      }
    }
  }
  
}
