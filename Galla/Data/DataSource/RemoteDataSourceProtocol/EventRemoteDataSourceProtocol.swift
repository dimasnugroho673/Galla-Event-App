//
//  EventRemoteDataSourceProtocol.swift
//  Galla
//
//  Created by Dimas Putro on 13/07/22.
//

import Foundation

protocol EventRemoteDataSourceProtocol {
  func fetchPopularEvent(location: String, isFinished: Bool, completion: @escaping (Result<BaseResponse<[Event]>, ResponseError>) -> ())
  func fetchUpcomingEvent(location: String, completion: @escaping (Result<BaseResponse<[Event]>, ResponseError>) -> ())
  func fetchDetailEvent(uid: String, completion: @escaping (Result<BaseResponse<DetailEvent>, ResponseError>) -> ())
  func joinEvent(uid: String, completion: @escaping(BaseResponse<String>) -> ())
}
