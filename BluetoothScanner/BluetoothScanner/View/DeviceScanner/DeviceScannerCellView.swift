//
//  DeviceCellView.swift
//  BluetoothScanner
//
//  Created by Marcelo Farjalla on 3/16/20.
//  Copyright © 2020 StackRank, LLC. All rights reserved.
//

import UIKit

class DeviceScannerCellView: UITableViewCell {

  @IBOutlet weak var label_DeviceName: UILabel!
  @IBOutlet weak var label_RSSI: UILabel!
  @IBOutlet weak var switch_isTracking: UISwitch!
  @IBOutlet weak var view_Container: UIView! {
    didSet {
      view_Container.layer.cornerRadius = 10
      view_Container.layer.shadowOpacity = 0.2
      view_Container.layer.shadowOffset = .zero
      view_Container.layer.shadowRadius = 2
    }
  }
  
  var deviceViewModel: DeviceScannerCellViewModel! {
    didSet {
      label_DeviceName.text = deviceViewModel.name
      label_RSSI.text = "\(deviceViewModel.distanceString)"
      switch_isTracking.isOn = deviceViewModel.isTracking
    }
  }
  
  @IBAction func toggleIsTracking(_ sender: Any) {
    self.deviceViewModel.toggleIsTracking()
  }
  
}
