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
    
    self.navigationController?.navigationBar.topItem?.title = "Scan Devices"
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    deviceScannerViewModel.startScan()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    deviceScannerViewModel.stopScan()
  }
  
  private func registerModelObservers() {
  self.deviceScannerViewModel.deviceScannerCellViewModels.addObserver(self) { listViewModels, change in
      
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
      
    }
    
    AlertManager.alertQueue.addObserver(self, options: [.new]) { alerts, change in
      
      guard alerts.count > 0 else { return }
      self.displayAlert(title: alerts[0].title, message: alerts[0].message)
      
      
      
    }
    
  }
  
  func displayAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
          switch action.style{
          case .default:
                print("default")

          case .cancel:
                print("cancel")

          case .destructive:
                print("destructive")


    }}))
    self.present(alert, animated: true, completion: nil)
  }
  
}

extension DeviceScannerViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.deviceScannerViewModel.deviceScannerCellViewModels.value.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceScannerCellView", for: indexPath) as! DeviceScannerCellView
    cell.deviceViewModel = self.deviceScannerViewModel.deviceScannerCellViewModels.value[indexPath.row]
    
    return cell
  }
  
}

