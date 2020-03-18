//
//  ViewController.swift
//  BluetoothScanner
//
//  Created by Marcelo Farjalla on 3/16/20.
//  Copyright © 2020 StackRank, LLC. All rights reserved.
//

import UIKit

class DeviceScannerViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var deviceScannerViewModel = DeviceScannerViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    registerModelObservers()
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    deviceScannerViewModel.startScan()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    deviceScannerViewModel.stopScan()
  }
  
  private func registerModelObservers() {
    self.deviceScannerViewModel.deviceViewModels.addObserver(self) { listViewModels, change in
      
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
      
    }
  }
}

extension DeviceScannerViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.deviceScannerViewModel.deviceViewModels.value.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceScannerCellView", for: indexPath) as! DeviceScannerCellView
    cell.deviceViewModel = self.deviceScannerViewModel.deviceViewModels.value[indexPath.row]
    
    return cell
  }
  
}

