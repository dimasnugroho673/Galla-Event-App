//
//  SettingsViewModel.swift
//  Galla
//
//  Created by Dimas Putro on 24/08/22.
//

import UIKit

class SettingsViewModel {

  private let userService: UserService

  var logoutStatus: Observable<Bool?> = Observable(nil)

  var settingsData: [Settings] = [
    Settings(sectionName: " ", data: [
      SettingsData(identifier: "process.logout", title: "Logout", icon: nil, toVC: nil)
    ])
  ]

  init(userService: UserService) {
    self.userService = userService
  }

  func logout() {
    userService.logout(with: MetaCredential(token: Constants.getToken())) { result in
      switch result {
      case .success(let status):
        self.logoutStatus.value = status
      case .failure(let error):
        print("DEBUG: \(error)")
      }
    }
  }
  
}

struct Settings {
  let sectionName: String
  let data: [SettingsData]
}

struct SettingsData {
  let identifier: String
  let title: String
  let icon: UIImage?
  let toVC: UIViewController?
}
