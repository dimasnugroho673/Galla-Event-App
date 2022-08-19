//
//  TicketRemoteDataSource.swift
//  Galla
//
//  Created by Dimas Putro on 15/08/22.
//

import Foundation

final class TicketRemoteDataSource: TicketRemoteDataSourceProtocol {

  private let userToken: String = UserDefaults.standard.string(forKey: "UserToken") ?? ""

  func getAll(isCanceled: Bool?, completion: @escaping (Result<BaseResponse<[Ticket]>, ResponseError>) -> ()) {
    guard let url = URL(string: "\(Constants.API_ENDPOINT)/user/ticket?is_canceled=\(isCanceled!)") else { return }

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "accept")
    request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        print("DEBUG: Error while Get Ticket Event: \(error.localizedDescription)")
        return
      }

      if let data = data {

        do {
          let result = try JSONDecoder().decode(BaseResponse<[Ticket]>.self, from: data)

          print("DEBUG: Ticket: \(result)")
          DispatchQueue.main.async {
            completion(.success(result))
          }
        } catch {
          print("DEBUG: Error while Get Ticket Event: \(error.localizedDescription)")
        }

      }
    }

    task.resume()
  }


}
