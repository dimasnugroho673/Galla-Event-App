//
//  EventService.swift
//  Galla
//
//  Created by Dimas Putro on 28/06/22.
//

import Foundation

class EventService: EventUseCase {

  private let eventRepository: EventRepository

  init(eventRepository: EventRepository) {
    self.eventRepository = eventRepository
  }

  func fetchPopularEvent(location: String, isFinished: Bool, completion: @escaping (Result<BaseResponse<[Event]>, ResponseError>) -> ()) {

    let newLoc = location.replacingOccurrences(of: " ", with: "+")

    return eventRepository.fetchPopularEvent(location: newLoc, isFinished: isFinished) { result in
      switch result {
        case .success(let data):
          return completion(.success(data))
        case .failure(let error):
          return completion(.failure(error))
      }
    }
  }

  func fetchUpcomingEvent(location: String, locationType: String, completion: @escaping (Result<BaseResponse<[Event]>, ResponseError>) -> ()) {

    let newLoc = location.replacingOccurrences(of: " ", with: "+")

    return eventRepository.fetchUpcomingEvent(location: newLoc, locationType: locationType) { result in
      switch result {
        case .success(let data):
          return completion(.success(data))
        case .failure(let error):
          return completion(.failure(error))
      }
    }
  }

  func fetchDetailEvent(uid: String, completion: @escaping (Result<BaseResponse<DetailEvent>, ResponseError>) -> ()) {
    return eventRepository.fetchDetailEvent(uid: uid) { result in
      switch result {
        case .success(let data):
          return completion(.success(data))
        case .failure(let error):
          return completion(.failure(error))
      }
    }
  }

  func joinEvent(uid: String, completion: @escaping (BaseResponse<String>) -> ()) {
    return eventRepository.joinEvent(uid: uid) { result in
      completion(result)
    }
  }

}
