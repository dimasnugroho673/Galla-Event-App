//
//  UserLocalDataSource.swift
//  Galla
//
//  Created by Dimas Putro on 25/06/22.
//

import Foundation

class UserLocalDataSource {

  func getUserData() -> User {
    var user: User?
    do {
      let retriveData = UserDefaults.standard.data(forKey: "LocalUserData")!

      let decode = try JSONDecoder().decode(User.self, from: retriveData)

      user = decode
//      print(decode)
//      DispatchQueue.main.async {
//        completion(decode)
//      }
    } catch {
      print("DEBUG: Error while retrive user data: persistent data not configure")
    }

    return user!
  }

  func saveUserData(_ data: User) {
    do {
      let encode = try JSONEncoder().encode(data)

      UserDefaults.standard.set(encode, forKey: "LocalUserData")
    } catch {
      fatalError("DEBUG: Error while saving user data: persistent data not configure")
    }
  }
  
}
