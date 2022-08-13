//
//  LocationService.swift
//  Galla
//
//  Created by Dimas Putro on 12/08/22.
//

class LocationService: LocationUseCase {

  private var locationRepository: LocationRepository

  init(locationRepository: LocationRepository) {
    self.locationRepository = locationRepository
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
    return locationRepository.getSelectedLocation()
  }

  func saveSelectedLocation(_ data: LocationResult) {
    return locationRepository.saveSelectedLocation(data)
  }

}
