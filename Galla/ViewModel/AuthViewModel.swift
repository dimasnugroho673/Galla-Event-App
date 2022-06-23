//
//  AuthViewModel.swift
//  Galla
//
//  Created by Dimas Putro on 22/06/22.
//

import Foundation

//public enum URLError: Error {
//
//  case invalidResponse
//  case addressUnreachable(URL)
//
//  public var errorDescription: String? {
//    switch self {
//    case .invalidResponse: return "The server responded with garbage."
//    case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
//    }
//  }
//
//}

enum AttempLoginStatus: Error {
  case emailPasswordNil
  case credentialNotValid

  var errorDescription: String? {
    switch self {
      case .credentialNotValid:
        return "Email or password wrong"
      case .emailPasswordNil:
        return "Email and Password cannot empty"
      }
  }
}

class AuthViewModel {

  var isLoggedIn: Observable<Bool> = Observable(false)
  var attempLoginStatus: Observable<Result<Bool, AttempLoginStatus>?> = Observable(nil)

  func isLogin() -> Observable<Bool> {
    return isLoggedIn
  }

  func attemptLogin(email: String, password: String) {
    if email == "" || password == "" {
      self.attempLoginStatus = Observable(.success(false))
      self.attempLoginStatus = Observable(.failure(.emailPasswordNil))

      return
    }

    if email == "dimasnugroho673@gmail.com" && password == "12345678" {
      print("MASUK BENAR...")
      self.isLoggedIn = Observable(true)
      self.attempLoginStatus = Observable(.success(true))

      return
    } else {
      self.isLoggedIn = Observable(false)
      self.attempLoginStatus = Observable(.success(false))
      self.attempLoginStatus = Observable(.failure(.credentialNotValid))

      return
    }

  }
}
