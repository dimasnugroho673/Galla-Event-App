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
    return eventRepository.fetchPopularEvent(location: location, isFinished: isFinished) { result in
      switch result {
        case .success(let data):
          return completion(.success(data))
        case .failure(let error):
          return completion(.failure(error))
      }
    }
  }

  func fetchUpcomingEvent(location: String, completion: @escaping (Result<BaseResponse<[Event]>, ResponseError>) -> ()) {
    return eventRepository.fetchUpcomingEvent(location: location) { result in
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

  
}
