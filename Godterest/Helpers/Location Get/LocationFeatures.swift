import SwiftUI
import CoreLocation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared = LocationViewModel() // Singleton instance
    
    var locationManager = CLLocationManager()
    @Published var currentLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var placemark: CLPlacemark?
    
    var authorizationStatusDescription: String {
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return "Authorized"
        case .denied:
            return "Denied"
        case .notDetermined:
            return "Not Determined"
        case .restricted:
            return "Restricted"
        @unknown default:
            return "Unknown"
        }
    }
    
    private override init() {
        super.init()
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.authorizationStatus = CLLocationManager.authorizationStatus()
    }
    
    func checkLocationAccess() {
        self.authorizationStatus = CLLocationManager.authorizationStatus()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.currentLocation = location
        reverseGeocode(location: location)
        self.locationManager.stopUpdatingLocation()
    }
    
    func reverseGeocode(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil, let placemark = placemarks?.first else {
                print("Reverse geocoding error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            self.placemark = placemark
        }
    }
    
    func askLocation(){
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}
