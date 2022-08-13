//
//  LocationRepositoryImplementation.swift
//  Galla
//
//  Created by Dimas Putro on 12/08/22.
//

class LocationRepositoryImplementation: LocationRepository {

  private let remoteDataSource: LocationRemoteDataSourceProtocol
  private let localDataSource: LocationLocalDataSourceProtocol

  init(remoteDataSource: LocationRemoteDataSourceProtocol, localDataSource: LocationLocalDataSourceProtocol) {
    self.remoteDataSource = remoteDataSource
    self.localDataSource = localDataSource
  }

  func search(_ keyword: String, completion: @escaping (Result<BaseResponse<[LocationResult]>, ResponseError>) -> ()) {
    return remoteDataSource.search(keyword) { result in
      switch result {
      case .success(let data):
        return completion(.success(data))
      case .failure(let error):
        return completion(.failure(error))
      }
    }
  }

  func getSelectedLocation() -> LocationResult {
    return localDataSource.getSelectedLocation()
  }

  func saveSelectedLocation(_ data: LocationResult) {
    return localDataSource.saveSelectedLocation(data)
  }
}
