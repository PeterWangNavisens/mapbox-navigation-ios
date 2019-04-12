import Foundation
import CoreLocation
import MapboxDirections
import Mapbox

 public protocol Router: class, MGLLocationManagerDelegate{
    var eventsManager: EventsManager! { get }
    var locationManager: NavigationLocationManagerProtocol! { get }
    
    var usesDefaultUserInterface: Bool { get }
    var routeProgress: RouteProgress { get }
    func endNavigation(feedback: EndOfRouteFeedback?)

   var location: CLLocation? { get }
}
