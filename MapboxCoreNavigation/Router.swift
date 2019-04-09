import Foundation
import CoreLocation
import MapboxDirections
import Mapbox

@objc public protocol Router: class, MGLLocationManagerDelegate{
    @objc var eventsManager: EventsManager! { get }
    @objc var locationManager: NavigationLocationManagerProtocol! { get }
    
    var usesDefaultUserInterface: Bool { get }
    var routeProgress: RouteProgress { get }
    func endNavigation(feedback: EndOfRouteFeedback?)

    @objc var location: CLLocation? { get }
}
