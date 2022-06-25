//
//  Injection.swift
//  Galla
//
//  Created by Dimas Putro on 24/06/22.
//

import Foundation

class Injection {

  func provideHome() -> UserService {
    let remoteDataSource = UserRemoteDataSource()
    let localDataSource = UserLocalDataSource()
    let repository = UserRepositoryImplementation(remoteDataSource: remoteDataSource, localDataSource: localDataSource)

    return UserService(userRepository: repository)
  }
}
