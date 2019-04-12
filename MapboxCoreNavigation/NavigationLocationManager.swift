import Foundation
import CoreLocation
#if os(iOS)
import UIKit
#endif

#if os(iOS)
import Mapbox
#endif

/**
 `NavigationLocationManager` is the base location manager which handles permissions and background modes.
 */
public
 protocol NavigationLocationManagerProtocol : MGLLocationManager {

    
  var activityType:CLActivityType {get set } //add set for route controller
  
  //for navigation location manager
  weak var navDelegate:MGLLocationManagerDelegate?{get set}
  var location:CLLocation? {get set}
  var lastKnownLocation: CLLocation? {get set}
  //
  
}

@objc(MBNavigationLocationManager)
open class NavigationLocationManager: NSObject, NavigationLocationManagerProtocol, CLLocationManagerDelegate{
  
  public var distanceFilter:CLLocationDistance
  {
    get{
      return appleLocationManager.distanceFilter
    }
    set{
      appleLocationManager.distanceFilter = newValue
    }
  }
  public var desiredAccuracy:CLLocationAccuracy
  {
    get{
      return appleLocationManager.desiredAccuracy
    }
    set{
      appleLocationManager.desiredAccuracy = newValue
    }
  }
  public var activityType:CLActivityType
  {
    get{
      return appleLocationManager.activityType
    }
    set{
      appleLocationManager.activityType = newValue
    }
  }
  
  public var delegate: MGLLocationManagerDelegate?
  public weak var navDelegate:MGLLocationManagerDelegate?
  
  public var authorizationStatus: CLAuthorizationStatus
  {
      return CLLocationManager.authorizationStatus()
  }
  public var  location:CLLocation? {
    get{
      return appleLocationManager.location
    }
    set {
      //self.location = newValue
    }
  }
  
  public func requestAlwaysAuthorization() {
    appleLocationManager.requestAlwaysAuthorization()
  }
  
  public func requestWhenInUseAuthorization() {
    appleLocationManager.requestWhenInUseAuthorization()
  }
  
  public func startUpdatingLocation() {
    appleLocationManager.startUpdatingLocation()
  }
  
  public func stopUpdatingLocation() {
    appleLocationManager.stopUpdatingLocation()
  }
  
  public var headingOrientation: CLDeviceOrientation
  {
    get {
      return appleLocationManager.headingOrientation
    }
    set{
      appleLocationManager.headingOrientation = newValue
    }
  }
  
  public func startUpdatingHeading() {
    appleLocationManager.startUpdatingHeading()
  }
  
  public func stopUpdatingHeading() {
    appleLocationManager.stopUpdatingHeading()
  }
  
  public func dismissHeadingCalibrationDisplay() {
    appleLocationManager.dismissHeadingCalibrationDisplay()
  }
  
  
  var appleLocationManager:CLLocationManager = CLLocationManager()
  //
  public func locationManager(_ manager: CLLocationManager,
                       didUpdateLocations locations: [CLLocation])
  {
    navDelegate?.locationManager(self, didUpdate: locations)
  }
  
  
  public func locationManager(_ manager: CLLocationManager,
                       didFailWithError error: Error)
  {
    navDelegate?.locationManager(self, didFailWithError: error)
  }
  
  public func locationManager(_ manager: CLLocationManager,
                       didUpdateHeading newHeading: CLHeading)
  {
    navDelegate?.locationManager(self, didUpdate: newHeading)
  }
  
  public func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool
  {
    return false
  }
  //
  
  public var lastKnownLocation: CLLocation?
    
    override public init() {
        super.init()
        
        appleLocationManager.requestWhenInUseAuthorization()
        appleLocationManager.delegate = self
      
        if Bundle.main.backgroundModes.contains("location") {
            appleLocationManager.allowsBackgroundLocationUpdates = true
        }
    }
}
