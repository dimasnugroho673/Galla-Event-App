//
//  UserLocalDataSource.swift
//  Galla
//
//  Created by Dimas Putro on 25/06/22.
//

import Foundation

class UserLocalDataSource {

  func getUserData(completion: @escaping(User) -> ()) {
    do {
      let retriveData = UserDefaults.standard.data(forKey: "LocalUserData")!

      let decode = try JSONDecoder().decode(User.self, from: retriveData)

      print(decode)
      DispatchQueue.main.async {
        completion(decode)
      }
    } catch {
      print("DEBUG: Error while retrive user data: persistent data not configure")
    }
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
