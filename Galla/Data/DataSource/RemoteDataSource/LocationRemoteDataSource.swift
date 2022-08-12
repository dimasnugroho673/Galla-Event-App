//
//  LocationRemoteDataSource.swift
//  Galla
//
//  Created by Dimas Putro on 12/08/22.
//

import Foundation

final class LocationRemoteDataSource: LocationRemoteDataSourceProtocol {
  func search(_ keyword: String, completion: @escaping (Result<BaseResponse<LocationResult>, ResponseError>) -> ()) {
    guard let url = URL(string: "\(Constants.API_ENDPOINT)/locations?keyword=\(keyword)") else { return }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print("DEBUG: Error while searching Location: \(error.localizedDescription)")
        return
      }

      if let data = data {
        do {
          let result = try JSONDecoder().decode(BaseResponse<LocationResult>.self, from: data)

          DispatchQueue.main.async {
            completion(.success(result))
          }

          return
        } catch {
          DispatchQueue.main.async {
            completion(.failure(ResponseError.errorFetchingData))
          }
          print("DEBUG: Error while searching Location: \(error.localizedDescription)")
        }
      }
    }

    task.resume()
  }
}
