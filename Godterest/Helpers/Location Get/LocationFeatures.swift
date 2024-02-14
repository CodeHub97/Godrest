import SwiftUI
import CoreLocation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared = LocationViewModel() // Singleton instance

    private var locationManager = CLLocationManager()

    @Published var currentLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined

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

      if let location = locations.first {

          let geocoder = CLGeocoder()
          geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
              if let placemark = placemarks?.first {
                  print(placemark.name ?? "Unknown Location")
              } else {
                print("Unknown Location")
              }
          }
      }
    }

  func askLocation(){
    self.locationManager.delegate = self
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()

  }
}

