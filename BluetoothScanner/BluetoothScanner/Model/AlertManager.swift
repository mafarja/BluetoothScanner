//
//  ErrorManager.swift
//  BluetoothScanner
//
//  Created by Marcelo Farjalla on 3/22/20.
//  Copyright © 2020 StackRank, LLC. All rights reserved.
//

import Foundation

struct Alert {
  let title: String
  let message: String
}

class AlertManager {
  static var alertQueue: Observable<[Alert]> = Observable<[Alert]>([])
  
  static func queue(alert: Alert) {
    
    alertQueue.value.removeAll()
    alertQueue.value.append(alert)
    
  }
}
