//
//  EventRemoteDataSource.swift
//  Galla
//
//  Created by Dimas Putro on 28/06/22.
//

import Foundation

final class EventRemoteDataSource: EventRemoteDataSourceProtocol {

  private let userToken: String = UserDefaults.standard.string(forKey: "UserToken") ?? ""

  func fetchPopularEvent(location: String, isFinished: Bool, completion: @escaping (Result<BaseResponse<[Event]>, ResponseError>) -> ()) {
    guard let url = URL(string: "\(Constants.API_ENDPOINT)/events/popular?location=\(location)&is_finished=\(isFinished)") else { return }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print("DEBUG: Error while fetch Popular Event: \(error.localizedDescription)")
        return
      }

      if let data = data {
        do {

          let result = try JSONDecoder().decode(BaseResponse<[Event]>.self, from: data)

          DispatchQueue.main.async {
            completion(.success(result))
          }

          return

        } catch {
          DispatchQueue.main.async {
            completion(.failure(ResponseError.errorFetchingData))
          }
          print("DEBUG: Error while fetch Popular Event: \(error.localizedDescription)")
        }
      }

    }

    task.resume()
  }

  func fetchUpcomingEvent(location: String, completion: @escaping (Result<BaseResponse<[Event]>, ResponseError>) -> ()) {
    guard let url = URL(string: "\(Constants.API_ENDPOINT)/events/upcoming?location=\(location)") else { return }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print("DEBUG: Error while fetch Upcoming Event: \(error.localizedDescription)")
        return
      }

      if let data = data {
        do {
          let result = try JSONDecoder().decode(BaseResponse<[Event]>.self, from: data)

          DispatchQueue.main.async {
            completion(.success(result))
          }

          return

        } catch {
          DispatchQueue.main.async {
            completion(.failure(ResponseError.errorFetchingData))
          }
          print("DEBUG: Error while fetch Upcoming Event: \(error.localizedDescription)")
        }
      }

    }

    task.resume()
  }


  func fetchDetailEvent(uid: String, completion: @escaping (Result<BaseResponse<DetailEvent>, ResponseError>) -> ()) {
    guard let url = URL(string: "\(Constants.API_ENDPOINT)/event/\(uid)") else { return }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print("DEBUG: Error while fetch Upcoming Event: \(error.localizedDescription)")
        return
      }

      if let data = data {
        do {
          let result = try JSONDecoder().decode(BaseResponse<DetailEvent>.self, from: data)

          DispatchQueue.main.async {
            completion(.success(result))
          }

          return

        } catch {
          DispatchQueue.main.async {
            completion(.failure(ResponseError.errorFetchingData))
          }
          print("DEBUG: Error while fetch Upcoming Event: \(error.localizedDescription)")
        }
      }

    }

    task.resume()
  }

  func joinEvent(uid: String, completion: @escaping(BaseResponse<String>) -> ()) {
    guard let url = URL(string: "\(Constants.API_ENDPOINT)/event/\(uid)/join") else { return }

    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
    request.httpMethod = "POST"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        print("DEBUG: Error while Join Event: \(error.localizedDescription)")
        return
      }

      if let data = data {
        do {
          let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)

          print("DEBUG: \(result)")
          DispatchQueue.main.async {
            completion(result)
          }

          return

        } catch {
          print("DEBUG: Error while Join Event: \(error.localizedDescription)")
        }
      }
    }

    task.resume()

  }
}
