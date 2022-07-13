//
//  UserLocalDataSourceProtocol.swift
//  Galla
//
//  Created by Dimas Putro on 13/07/22.
//

protocol UserLocalDataSourceProtocol {
  func getUserData() -> User
  func saveUserData(_ data: User)
}
