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
}

struct User: Codable {
  let uid: String
  let name: String
  let email: String
  let joined: String
}

struct MetaCredential: Codable {
  let token: String
}


