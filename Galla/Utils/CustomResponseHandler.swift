//
//  CustomResponseHandler.swift
//  Galla
//
//  Created by Dimas Putro on 24/06/22.
//

enum CustomResponse: Codable {
  case user(User)
  case string(String)
  case unknown

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()

    if let userValue = try? container.decode(User.self) {
      self = .user(userValue)
      return
    }

    if let stringValue = try? container.decode(String.self) {
      self = .string(stringValue)
      return
    }

    self = .unknown
  }

  func get() -> Any {
    switch self {
    case .user(let user):
      return user
    case .string(let string):
      return string
    case .unknown:
      return "Unknown result"
    }
  }

}
