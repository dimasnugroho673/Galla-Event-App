//
//  User.swift
//  Galla
//
//  Created by Dimas Putro on 24/06/22.
//

import Foundation

struct AuthCredential {
  let name: String
  let email: String
  let password: String
  let confirmPassword: String
}

struct User: Codable {
  let uid: String
  let name: String
  let email: String
  let joined: String
  let eventJoined: Int
  let eventCanceled: Int

  enum CodingKeys: String, CodingKey {
    case uid, name, email, joined
    case eventJoined = "event_joined"
    case eventCanceled = "event_canceled"
  }
}

struct MetaCredential: Codable {
  let token: String
}


