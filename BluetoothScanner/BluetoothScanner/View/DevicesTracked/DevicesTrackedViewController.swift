//
//  DevicesTrackedViewController.swift
//  BluetoothScanner
//
//  Created by Marcelo Farjalla on 3/20/20.
//  Copyright © 2020 StackRank, LLC. All rights reserved.
//

import UIKit

class DevicesTrackedViewController: UITableViewController {
  
  let devicesTrackedViewModel = DevicesTrackedViewModel()
  
  override func viewDidLoad() {
    registerModelObservers()
    self.navigationItem.rightBarButtonItem = editButtonItem
    
    self.navigationController?.navigationBar.topItem?.title = "Devices Tracked"
  }
  
  override func viewWillAppear(_ animated: Bool) {
    devicesTrackedViewModel.requestTrackedDevices()

  }
  
  private func registerModelObservers() {
    self.devicesTrackedViewModel.devicesTrackedCellViewModels.addObserver(self) { deviceViewModels, change in
      
      self.tableView.reloadData()
      
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return self.devicesTrackedViewModel.devicesTrackedCellViewModels.value.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "DevicesTrackedCellView", for: indexPath) as! DevicesTrackedCellView
    
    cell.devicesTrackedCellViewModel = self.devicesTrackedViewModel.devicesTrackedCellViewModels.value[indexPath.row]
    
    return cell
    
  }
  
}

// drag and drop
extension DevicesTrackedViewController {
  
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        
        self.devicesTrackedViewModel.delete(device: self.devicesTrackedViewModel.devicesTrackedCellViewModels.value[indexPath.row])
    
      }
    }

}
