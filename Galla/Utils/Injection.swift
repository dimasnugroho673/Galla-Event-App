//
//  Injection.swift
//  Galla
//
//  Created by Dimas Putro on 24/06/22.
//

import Foundation

class Injection {

  func provideHome() -> UserService {
    let dataSource = UserRemoteDataSource()
    let repository = UserRepositoryImplementation(dataSource: dataSource)

    return UserService(userRepository: repository)
  }
}
