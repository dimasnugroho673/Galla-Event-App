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

  func provideSearch() -> LocationService {
    let remoteDataSource = LocationRemoteDataSource()
    let localDataSource = LocationLocalDataSource()
    let repository = LocationRepositoryImplementation(remoteDataSource: remoteDataSource, localDataSource: localDataSource)

    return LocationService(locationRepository: repository)
  }

  func provideTicket() -> TicketService {
    let remoteDataSource = TicketRemoteDataSource()
    let localDataSource = TicketLocalDataSource()
    let repository = TicketRepositoryImplementation(remoteDataSource: remoteDataSource, localDataSource: localDataSource)

    return TicketService(repository: repository)
  }
}
