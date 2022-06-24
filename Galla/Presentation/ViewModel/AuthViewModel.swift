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

//enum AttempLoginStatus: Error {
//  case emailPasswordNil
//  case credentialsCannotEmpty
//
//  var errorDescription: String? {
//    switch self {
//      case .credentialsCannotEmpty:
//        return "Email or password wrong"
//      case .emailPasswordNil:
//        return "Email and Password cannot empty"
//      }
//  }
//}

class AuthViewModel {

  private let userService: UserService

  var isLoading: Observable<Bool> = Observable(false)
  var isLoggedIn: Observable<Bool> = Observable(false)
  var attempLoginStatus: Observable<Result<Bool, ResponseError>?> = Observable(.success(false))

  init(userService: UserService) {
    self.userService = userService
  }

  func isLogin() -> Observable<Bool> {
    return isLoggedIn
  }

  func attemptLogin(email: String, password: String) {
    isLoading.value = true

    userService.login(email: email, password: password) { result in
      
      self.isLoading.value = false

      switch result {
      case .success(let data):
        self.attempLoginStatus.value = .success(data.status)
      case .failure(let error):
        self.attempLoginStatus.value = .failure(error)
      }
    }

  }
}
