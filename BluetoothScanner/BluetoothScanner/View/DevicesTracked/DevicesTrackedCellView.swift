//
//  DevicesTrackedCellView.swift
//  BluetoothScanner
//
//  Created by Marcelo Farjalla on 3/20/20.
//  Copyright © 2020 StackRank, LLC. All rights reserved.
//

import UIKit

class DevicesTrackedCellView: UITableViewCell {
  
  @IBOutlet weak var label_DeviceName: UILabel!
  @IBOutlet weak var label_LastScanned: UILabel!
  @IBOutlet weak var view_Container: UIView! {
    didSet {
      view_Container.layer.cornerRadius = 10
      view_Container.layer.shadowOpacity = 0.2
      view_Container.layer.shadowOffset = .zero
      view_Container.layer.shadowRadius = 2
    }
  }
  
  var devicesTrackedCellViewModel: DevicesTrackedCellViewModel! {
    didSet {
      label_DeviceName.text = devicesTrackedCellViewModel.deviceName
      label_LastScanned.text = devicesTrackedCellViewModel.lastScannedString
      
      
      
      
    }
  }

}
