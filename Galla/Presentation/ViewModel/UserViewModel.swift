//
//  AuthViewModel.swift
//  Galla
//
//  Created by Dimas Putro on 22/06/22.
//

class UserViewModel {

  private let userService: UserService

  var isLoading: Observable<Bool> = Observable(false)
  var isLoggedIn: Observable<Bool> = Observable(false)
  var attemptLoginStatus: Observable<Result<Bool, ResponseError>?> = Observable(.success(false))
  var attemptRegisterStatus: Observable<Result<Bool, ResponseError>?> = Observable(.success(false))

  var user: Observable<User>?

  init(userService: UserService) {
    self.userService = userService
  }

  func isLogin() {
    if userService.currentUser().uid != "" {
      isLoggedIn.value = true
    }
  }

  func attemptLogin(email: String, password: String) {
    isLoading.value = true

    userService.login(email: email, password: password) { result in
      
      self.isLoading.value = false

      switch result {
        case .success(let data):
          self.user?.value = data.data
          self.attemptLoginStatus.value = .success(data.status)
        case .failure(let error):
          self.attemptLoginStatus.value = .failure(error)
        }
    }
  }

  func attemptRegister(credentials: AuthCredential) {
    isLoading.value = true

    userService.register(with: credentials) { result in
      self.isLoading.value = false

      switch result {
      case .success(let data):
        self.user?.value = data.data
        self.attemptRegisterStatus.value = .success(data.status)
      case .failure(let error):
        self.attemptRegisterStatus.value = .failure(error)
      }
    }
  }
}
