//
//  EventUseCase.swift
//  Galla
//
//  Created by Dimas Putro on 28/06/22.
//

protocol EventUseCase {
  func search(keyword: String, location: String?, locationType: String?, isFinished: Bool?, completion: @escaping (Result<BaseResponse<[Event]>, ResponseError>) -> ())
  func fetchPopularEvent(location: String, isFinished: Bool, locationType: String, completion: @escaping(Result<BaseResponse<[Event]>, ResponseError>) -> ())
  func fetchUpcomingEvent(location: String, locationType: String, completion: @escaping(Result<BaseResponse<[Event]>, ResponseError>) -> ())
  func fetchDetailEvent(uid: String, completion: @escaping(Result<BaseResponse<DetailEvent>, ResponseError>) -> ())
  func joinEvent(uid: String, completion: @escaping(BaseResponse<String>) -> ())
  func fetchFavoriteEvent(completion: @escaping(Result<BaseResponse<[Event]>, ResponseError>) -> ())
  func checkFavorite(uid: String, completion: @escaping (BaseResponse<Bool>) -> ())
  func addFavorite(uid: String, completion: @escaping (BaseResponse<String>) -> ())
  func removeFavorite(uid: String, completion: @escaping (BaseResponse<String>) -> ())
}
