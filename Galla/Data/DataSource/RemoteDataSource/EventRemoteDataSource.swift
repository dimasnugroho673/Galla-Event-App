//
//  EventRemoteDataSource.swift
//  Galla
//
//  Created by Dimas Putro on 28/06/22.
//

import Foundation

final class EventRemoteDataSource: EventRemoteDataSourceProtocol {

  private let userToken: String = UserDefaults.standard.string(forKey: "UserToken") ?? ""

  func search(keyword: String, location: String?, locationType: String?, isFinished: Bool?, completion: @escaping (Result<BaseResponse<[Event]>, ResponseError>) -> ()) {
    guard let url = URL(string: "\(Constants.API_ENDPOINT)/events?keyword=\(keyword)") else { return }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print("DEBUG: Error while fetch Search Event: \(error.localizedDescription)")
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
          print("DEBUG: Error while decode Search Event: \(error.localizedDescription)")
        }
      }

    }

    task.resume()
  }

  func fetchPopularEvent(location: String, isFinished: Bool, locationType: String, completion: @escaping (Result<BaseResponse<[Event]>, ResponseError>) -> ()) {
    guard let url = URL(string: "\(Constants.API_ENDPOINT)/events/popular?location=\(location)&is_finished=\(isFinished)&location_type=\(locationType)") else { return }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print("DEBUG: Error while fetch Popular Event: \(error.localizedDescription)")
        return
      }

      if let data = data {
//        print("DEBUG: url: \(url)")
//        print("DEBUG: \(String(data: data, encoding: .utf8))")

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
          print("DEBUG: Error while decode Popular Event: \(error.localizedDescription)")
        }
      }

    }

    task.resume()
  }

  func fetchUpcomingEvent(location: String, locationType: String, completion: @escaping (Result<BaseResponse<[Event]>, ResponseError>) -> ()) {
    guard let url = URL(string: "\(Constants.API_ENDPOINT)/events/upcoming?location=\(location)&location_type=\(locationType)") else { return }

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
          print("DEBUG: Error while decode Upcoming Event: \(error.localizedDescription)")
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
          print("DEBUG: Error while decode Detail Event: \(error.localizedDescription)")
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

//          print("DEBUG: \(result)")
          DispatchQueue.main.async {
            completion(result)
          }

          return

        } catch {
          print("DEBUG: Error while decode Join Event: \(error.localizedDescription)")
        }
      }
    }

    task.resume()

  }

  func fetchFavoriteEvent(completion: @escaping (Result<BaseResponse<[Event]>, ResponseError>) -> ()) {
    guard let url = URL(string: "\(Constants.API_ENDPOINT)/events/favorite") else { return }

    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        print("DEBUG: Error while fetch Favorite Event: \(error.localizedDescription)")
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
          print("DEBUG: Error while decode Favorite Event: \(error.localizedDescription)")
        }
      }
    }

    task.resume()
  }

  func checkFavorite(uid: String, completion: @escaping (BaseResponse<Bool>) -> ()) {
    guard let url = URL(string: "\(Constants.API_ENDPOINT)/event/\(uid)/favorite") else { return }

    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        print("DEBUG: Error while fetch Favorite Event: \(error.localizedDescription)")
        return
      }

      if let data = data {
        do {
          let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data)

          DispatchQueue.main.async {
            completion(result)
          }

          return
        } catch {
          print("DEBUG: Error while decode Favorite Event: \(error.localizedDescription)")
        }
      }
    }

    task.resume()
  }

  func addFavorite(uid: String, completion: @escaping (BaseResponse<String>) -> ()) {
    guard let url = URL(string: "\(Constants.API_ENDPOINT)/event/\(uid)/favorite") else { return }

    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
    request.httpMethod = "POST"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        print("DEBUG: Error while fetch Favorite Event: \(error.localizedDescription)")
        return
      }

      if let data = data {
        do {
          let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)

          DispatchQueue.main.async {
            completion(result)
          }

          return
        } catch {
          print("DEBUG: Error while decode Favorite Event: \(error.localizedDescription)")
        }
      }
    }

    task.resume()
  }

  func removeFavorite(uid: String, completion: @escaping (BaseResponse<String>) -> ()) {
    guard let url = URL(string: "\(Constants.API_ENDPOINT)/event/\(uid)/favorite") else { return }

    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
    request.httpMethod = "DELETE"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        print("DEBUG: Error while fetch Favorite Event: \(error.localizedDescription)")
        return
      }

      if let data = data {
        do {
          let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)

          DispatchQueue.main.async {
            completion(result)
          }

          return
        } catch {
          print("DEBUG: Error while decode Favorite Event: \(error.localizedDescription)")
        }
      }
    }

    task.resume()
  }
}
