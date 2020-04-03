//
//  CoreDataManager.swift
//  FamHub
//
//  Created by Marcelo Farjalla on 11/25/19.
//  Copyright © 2019 StackRank, LLC. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
  
  static var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "BluetoothScanner")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
      
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  static var backgroundContext: NSManagedObjectContext = {
    return CoreDataManager.persistentContainer.newBackgroundContext()
  }()
  
  init() {
 
    
  }
  
}
