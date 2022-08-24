//
//  Constants.swift
//  Galla
//
//  Created by Dimas Putro on 24/06/22.
//

import Foundation

class Constants {
  static let API_ENDPOINT = "https://galla-backend.herokuapp.com/api"

  static func getToken() -> String {
    return UserDefaults.standard.string(forKey: "UserToken") ?? ""
  }
}
