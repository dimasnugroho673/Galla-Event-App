//
//  Injection.swift
//  Galla
//
//  Created by Dimas Putro on 24/06/22.
//

import Foundation

class Injection {

  func provideAuth() -> UserService {
    let remoteDataSource = UserRemoteDataSource()
    let localDataSource = UserLocalDataSource()
    let repository = UserRepositoryImplementation(remoteDataSource: remoteDataSource, localDataSource: localDataSource)

    return UserService(userRepository: repository)
  }

  func provideHome() -> EventService {
    let remoteDataSource = EventRemoteDataSource()
    let repository = EventRepositoryImplementation(remoteDataSource: remoteDataSource)

    return EventService(eventRepository: repository)
  }

  func provideDetail() -> EventService {
    let remoteDataSource = EventRemoteDataSource()
    let repository = EventRepositoryImplementation(remoteDataSource: remoteDataSource)

    return EventService(eventRepository: repository)
  }
}
