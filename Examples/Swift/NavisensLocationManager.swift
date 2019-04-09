//
//  NavisensLocationManager.swift
//  GoggleBox
//
//  Created by nav on 9/18/18.
//  Copyright © 2018 Navisens. All rights reserved.
//
import Mapbox
import MapboxNavigation
import MotionDnaSDK
import MapboxCoreNavigation
import UIKit

class NavisensLocationManager: MotionDnaSDK, MotionDnaLocationManagerDelegate,NavigationLocationManagerProtocol {
  
  var navDelegate: MGLLocationManagerDelegate?
  
  var activityType: CLActivityType = .other
  
  var location: CLLocation?
  
  var lastKnownLocation: CLLocation?
  
  func locationManager(_ manager: MotionDnaLocationManagerDataSource!, didUpdate locations: [CLLocation]!) {
    DispatchQueue.main.async {
      print("didUpdate",locations[0])
      self.delegate?.locationManager(self, didUpdate: locations)
      self.navDelegate?.locationManager(self, didUpdate: locations)
    }
  }
  
  func locationManager(_ manager: MotionDnaLocationManagerDataSource!, didFailWithError error: Error!) {
    print((error as NSError).localizedDescription)
    self.delegate?.locationManager(self, didFailWithError: error)
    self.navDelegate?.locationManager(self, didFailWithError: error)
  }
  
  func locationManager(_ manager: MotionDnaLocationManagerDataSource!, didUpdate newHeading: CLHeading!) {
     DispatchQueue.main.async {
      self.delegate?.locationManager(self, didUpdate: newHeading)
      self.navDelegate?.locationManager(self, didUpdate: newHeading)
    }
  }
  
  func locationManagerShouldDisplayHeadingCalibration(_ manager: MotionDnaLocationManagerDataSource!) -> Bool {
    return (self.delegate?.locationManagerShouldDisplayHeadingCalibration(self))!
  }
 
  override init() {
    super.init()
    self.motionDnaDelegate = self
  }
  
  var delegate: MGLLocationManagerDelegate?

  override func startUpdatingLocation() {
    self.runMotionDna("4e7485cfe0c552a50112f33c573dca8c4e174786a59a6e407a589aa6d1d71d7a")
    self.setLocationNavisens()
    self.setBackgroundModeEnabled(true)
    self.setBackpropagationEnabled(true)
    self.setCallbackUpdateRateInMs(100)
    self.setExternalPositioningState(HIGH_ACCURACY)
    self.setPowerMode(PERFORMANCE)
  }
  
}
