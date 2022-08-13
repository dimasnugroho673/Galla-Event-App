//
//  EventRepository.swift
//  Galla
//
//  Created by Dimas Putro on 28/06/22.
//

protocol EventRepository {
  func fetchPopularEvent(location: String, isFinished: Bool, locationType: String, completion: @escaping(Result<BaseResponse<[Event]>, ResponseError>) -> ())
  func fetchUpcomingEvent(location: String, locationType: String, completion: @escaping(Result<BaseResponse<[Event]>, ResponseError>) -> ())
  func fetchDetailEvent(uid: String, completion: @escaping(Result<BaseResponse<DetailEvent>, ResponseError>) -> ())
  func joinEvent(uid: String, completion: @escaping(BaseResponse<String>) -> ())
}
