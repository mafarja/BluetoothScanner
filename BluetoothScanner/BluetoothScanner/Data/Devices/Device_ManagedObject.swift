//
//  Device_ManagedObject.swift
//  BluetoothScanner
//
//  Created by Marcelo Farjalla on 3/18/20.
//  Copyright © 2020 StackRank, LLC. All rights reserved.
//

import Foundation
import CoreData

@objc(Device_ManagedObject)

class Device_ManagedObject: NSManagedObject {
  
  @NSManaged var id: UUID
  @NSManaged var name: String
  @NSManaged var givenName: String
  @NSManaged var isTracking: Bool
  @NSManaged var latitude: Double
  @NSManaged var longitude: Double
  @NSManaged var user_id: String
  @NSManaged var lastScanned: Date?
  
}
