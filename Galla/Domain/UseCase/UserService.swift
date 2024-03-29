//
//  UserService.swift
//  Galla
//
//  Created by Dimas Putro on 24/06/22.
//

import Foundation

class UserService: UserUseCase {

  private let userRepository: UserRepository

  init(userRepository: UserRepository){
    self.userRepository = userRepository
  }

  func register(with credentials: AuthCredential, completion: @escaping (Result<BaseResponse<User>, ResponseError>) -> ()) {

    if credentials.name == "" || credentials.email == "" || credentials.password == "" || credentials.confirmPassword == "" {
      return completion(.failure(ResponseError.credentialsCannotEmpty))
    }

    if !Utilities.validateEmail(candidate: credentials.email) {
      return completion(.failure(ResponseError.customError("Email address not valid format")))
    }

    if credentials.password.count <= 6 {
      return completion(.failure(ResponseError.customError("Password must be at least 6 characters")))
    }

    if credentials.password != credentials.confirmPassword {
      return completion(.failure(ResponseError.customError("Password and confirm password must be same")))
    }

    return userRepository.register(with: credentials) { result in
      switch result {
      case .success(let data):
        self.saveUserData(with: data.data)

        // sementara set user tokennya di userdefault, kedepannya akan menggunakan KeyChain
        UserDefaults.standard.set(data.meta?.token, forKey: "UserToken")
        
        completion(.success(data))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func login(email: String, password: String, completion: @escaping (Result<BaseResponse<User>, ResponseError>) -> ()) {

    if email == "" || password == "" {
      return completion(.failure(ResponseError.credentialsCannotEmpty))
    }

    if !Utilities.validateEmail(candidate: email) {
      return completion(.failure(ResponseError.customError("Email address not valid format")))
    }

    return userRepository.login(email: email, password: password) { result in
      switch result {
      case .success(let data):
        self.saveUserData(with: data.data)

        // sementara set user tokennya di userdefault, kedepannya akan menggunakan KeyChain
        UserDefaults.standard.set(data.meta?.token, forKey: "UserToken")

        completion(.success(data))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func logout(with metaCredential: MetaCredential, completion: @escaping (Result<Bool, ResponseError>) -> ()) {
    return userRepository.logout { result in
      switch result {
      case .success(let data):
        completion(.success(data))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func fetchUserData(with metaCredential: MetaCredential, completion: @escaping (Result<BaseResponse<User>, ResponseError>) -> ()) {
    return userRepository.fetchUserData(with: metaCredential) { result in
      switch result {
      case .success(let data):
        completion(.success(data))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func saveUserData(with data: User) {
    return userRepository.saveUserData(with: data)
  }


  func currentUser() -> User {
    return userRepository.currentUser()
  }


}
