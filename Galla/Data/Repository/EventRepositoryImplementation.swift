//
//  EventRepositoryImplementation.swift
//  Galla
//
//  Created by Dimas Putro on 28/06/22.
//

class EventRepositoryImplementation: EventRepository {

  private let remoteDataSource: EventRemoteDataSourceProtocol

  init(remoteDataSource: EventRemoteDataSourceProtocol) {
    self.remoteDataSource = remoteDataSource
  }

  func fetchPopularEvent(location: String, isFinished: Bool, completion: @escaping (Result<BaseResponse<[Event]>, ResponseError>) -> ()) {
    return remoteDataSource.fetchPopularEvent(location: location, isFinished: isFinished) { result in
      switch result {
        case .success(let data):
          return completion(.success(data))
        case .failure(let error):
          return completion(.failure(error))
      }
    }
  }

  func fetchUpcomingEvent(location: String, locationType: String, completion: @escaping (Result<BaseResponse<[Event]>, ResponseError>) -> ()) {
    return remoteDataSource.fetchUpcomingEvent(location: location, locationType: locationType) { result in
      switch result {
        case .success(let data):
          return completion(.success(data))
        case .failure(let error):
          return completion(.failure(error))
      }
    }
  }

  func fetchDetailEvent(uid: String, completion: @escaping (Result<BaseResponse<DetailEvent>, ResponseError>) -> ()) {
    return remoteDataSource.fetchDetailEvent(uid: uid) { result in
      switch result {
        case .success(let data):
          return completion(.success(data))
        case .failure(let error):
          return completion(.failure(error))
      }
    }
  }

  func joinEvent(uid: String, completion: @escaping (BaseResponse<String>) -> ()) {
    return remoteDataSource.joinEvent(uid: uid) { result in
      completion(result)
    }
  }

}
