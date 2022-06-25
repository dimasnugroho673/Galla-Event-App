//
//  UserRemoteDataSource.swift
//  Galla
//
//  Created by Dimas Putro on 24/06/22.
//

import Foundation

class UserRemoteDataSource {
  func register(with credentials: AuthCredential, completion: @escaping (Result<BaseResponse<User>, ResponseError>) -> ()) {
    guard let url = URL(string: "\(Constants.API_ENDPOINT)/register") else { return }

    let body: [String: String] = [
      "name": credentials.name,
      "email": credentials.email,
      "password": credentials.password
    ]

    guard let finalBody = try? JSONEncoder().encode(body) else { return}

    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = finalBody

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        print("DEBUG: Error while calling API: \(error.localizedDescription)")
      }

//      print("response...\(String(describing: response))")
      if let data = data {
        do {
          let parseData = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
          let status = parseData["status"] as! Bool

          if status {
            let result = try JSONDecoder().decode(BaseResponse<User>.self, from: data)

            print("DEBUG: result: \(result)")
            DispatchQueue.main.async {
              completion(.success(result))
            }

            return
          }

          DispatchQueue.main.async {
            completion(.failure(.errorFromAPI(parseData["data"] as! String)))
          }

        } catch let error {
          print("DEBUG: Error while calling API: \(error.localizedDescription)")
        }
      }
    }

    task.resume()
  }

  func login(withEmail email: String, withPassword password: String, completion: @escaping (Result<BaseResponse<User>, ResponseError>) -> ()) {

    guard let url = URL(string: "\(Constants.API_ENDPOINT)/login") else { return }

    let body: [String: String] = [
      "email": email,
      "password": password,
    ]

    guard let finalBody = try? JSONEncoder().encode(body) else { return }

    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = finalBody

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      if let _ = error {
        completion(.failure(.errorFetchingData))
      }

      if let data = data {
        do {
          let parsedData = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
          let status = parsedData["status"] as! Bool

          if status {
            let userData = try JSONDecoder().decode(BaseResponse<User>.self, from: data)

            print("DEBUG: result: \(userData)")
            DispatchQueue.main.async {
              completion(.success(userData))
            }

            return
          }

          DispatchQueue.main.async {
            completion(.failure(.errorFromAPI(parsedData["data"] as! String)))
          }

        } catch {
          print(error.localizedDescription)
          DispatchQueue.main.async {
            completion(.failure(.errorFetchingData))
          }
        }
      }
    }

    task.resume()
  }

  func logout(completion: @escaping (Result<Bool, ResponseError>) -> ()) {
    completion(.success(true))
  }

  //  func fetchUserData(withMetaCredential metaCredential: MetaCredential, completion: @escaping (Result<BaseResponse<User>, ResponseError>) -> ()) {
  //    completion(.success(BaseResponse(User(uid: "131", name: "D", email: "", joined: ""))))
  //  }

  //  private func execute<T: Any>(request: T) {
  //
  //  }
}
