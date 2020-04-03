//
//  DeviceMapViewController.swift
//  BluetoothScanner
//
//  Created by Marcelo Farjalla on 3/22/20.
//  Copyright © 2020 StackRank, LLC. All rights reserved.
//

import UIKit
import MapKit

class DeviceMapViewController: UIViewController {
  @IBOutlet weak var mapView: MKMapView!
  
  let deviceMapViewModel = DeviceMapViewModel()
  
  override func viewDidLoad() {
    registerObservers()
    deviceMapViewModel.getCurrentLocation()
  self.navigationController?.navigationBar.topItem?.title = "Find on Map"
  }
  
  private func registerObservers() {
    deviceMapViewModel.currentLocation.addObserver(self) { location, change in
      
      self.centerMapOnLocation(location: CLLocation(latitude: location.latitude, longitude: location.longitude))
      
    }
    
    deviceMapViewModel.devices.addObserver(self, options: [.initial, .new]) { devices, change in
      self.mapDeviceLocations()
    }
    
  }

  let regionRadius: CLLocationDistance = 10
  private func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    mapView.setRegion(coordinateRegion, animated: true)
  }
  
  private func mapDeviceLocations() {
    
    self.mapView.removeAnnotations(mapView.annotations)
    
    for device in deviceMapViewModel.devices.value {
      guard let location = device.location else { continue }
      
      
      
      let annotation = MKPointAnnotation()
      annotation.title = device.name
      annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
      self.mapView.addAnnotation(annotation)
      
    }
    
  }
  
}
