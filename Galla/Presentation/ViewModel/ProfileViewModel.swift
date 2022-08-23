//
//  ProfileViewModel.swift
//  Galla
//
//  Created by Dimas Putro on 23/08/22.
//

class ProfileViewModel {

  private let userService: UserService

  var isLoading: Observable<Bool> = Observable(false)
  var errorMessage: Observable<String> = Observable("")

  var user: Observable<User> = Observable(User(uid: "", name: "", email: "", joined: ""))

  init(userService: UserService) {
    self.userService = userService
  }

  func fetchUserData(refresh: Bool = false) {
    isLoading.value = refresh ? false : true

    userService.fetchUserData(with: MetaCredential(token: Constants.getToken())) { result in
      switch result {
      case .success(let data):
        self.user.value = data.data
        print("DEBUG: \(data)")
        self.isLoading.value = false
      case .failure(let error):
        self.errorMessage.value = error.errorDescription ?? ""
      }
    }
  }

}

