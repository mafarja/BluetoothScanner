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
  
  var deviceViewModel: DeviceViewModel! {
    didSet {
      label_DeviceName.text = deviceViewModel.name
      label_RSSI.text = "\(deviceViewModel.rssi)"
    }
  }
  

}
