//
//  EventRepositoryImplementation.swift
//  Galla
//
//  Created by Dimas Putro on 28/06/22.
//

class EventRepositoryImplementation: EventRepository {

  private let remoteDataSource: EventRemoteDataSource

  init(remoteDataSource: EventRemoteDataSource) {
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

  func fetchUpcomingEvent(location: String, completion: @escaping (Result<BaseResponse<[Event]>, ResponseError>) -> ()) {
    return remoteDataSource.fetchUpcomingEvent(location: location) { result in
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
}
