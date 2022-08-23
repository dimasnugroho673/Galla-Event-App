//
//  LocationService.swift
//  Galla
//
//  Created by Dimas Putro on 12/08/22.
//

import CoreLocation

class LocationService: NSObject, LocationUseCase {

  private var locationManager: CLLocationManager!
  private var currentCoordinate: CLLocation = CLLocation(latitude: 0.959810, longitude: 104.542785)
  private var currentLocationFromGPSString: String = ""

  private var locationRepository: LocationRepository

  init(locationRepository: LocationRepository) {
    self.locationRepository = locationRepository

    super.init()

    locationManager = CLLocationManager()
    requestPermission()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }
  
  func search(_ keyword: String, completion: @escaping (Result<BaseResponse<[LocationResult]>, ResponseError>) -> ()) {
    return locationRepository.search(keyword) { result in
      switch result {
      case .success(let data):
        return completion(.success(data))
      case .failure(let error):
        return completion(.failure(error))
      }
    }
  }

  func getSelectedLocation() -> LocationResult {
    let selectedLocation = locationRepository.getSelectedLocation()

    if selectedLocation.id == 0 {
      self.requestPermission()

      locationManager.startUpdatingLocation()

      self.getLocationFromGPS { location in
        let location = "\(location.split(separator: " ")[1])"

        self.locationRepository.search(location) { result in
          switch result {
          case .success(let data):
            self.saveSelectedLocation(data.data[0])
          case .failure(_):
            print("DEBUG: Error while get location using GPS")
          }
        }
      }
    }

    return selectedLocation
  }

  func saveSelectedLocation(_ data: LocationResult) {
    return locationRepository.saveSelectedLocation(data)
  }

  /// location function

  private func requestPermission() {
    locationManager.requestWhenInUseAuthorization()
  }

  private func getLocationFromGPS(onSuccess: @escaping((String) -> ())) {
    let geocoder = CLGeocoder()

    geocoder.reverseGeocodeLocation(currentCoordinate) { (placemark, error) in
      let _placemark = placemark?.first
      self.currentLocationFromGPSString = "\(_placemark?.locality ?? "-")"
      onSuccess(_placemark?.locality ?? "-")
    }
  }
}

extension LocationService: CLLocationManagerDelegate {
  internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }

    currentCoordinate = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.latitude)
  }
}
