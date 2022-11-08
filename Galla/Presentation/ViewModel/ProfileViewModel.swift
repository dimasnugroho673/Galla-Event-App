//
//  ProfileViewModel.swift
//  Galla
//
//  Created by Dimas Putro on 23/08/22.
//

class ProfileViewModel {

  private let userUseCase: UserUseCase
  private var locationUseCase: LocationUseCase

  var isLoading: Observable<Bool> = Observable(false)
  var errorMessage: Observable<String> = Observable("")

  var user: Observable<User> = Observable(User(uid: "", name: "", email: "", joined: "", eventJoined: 0, eventCanceled: 0))
  var selectedLocation: Observable<LocationResult> = Observable(LocationResult(type: "", id: 0, name: ""))

  init(userUseCase: UserUseCase, locationUseCase: LocationUseCase) {
    self.userUseCase = userUseCase
    self.locationUseCase = locationUseCase
  }

  func fetchUserData(refresh: Bool = false) {
    isLoading.value = refresh ? false : true

    userUseCase.fetchUserData(with: MetaCredential(token: Constants.getToken())) { result in
      switch result {
      case .success(let data):
        self.user.value = data.data
        self.isLoading.value = false
      case .failure(let error):
        self.errorMessage.value = error.errorDescription ?? ""
      }
    }

    selectedLocation.value = locationUseCase.getSelectedLocation()
  }

}

