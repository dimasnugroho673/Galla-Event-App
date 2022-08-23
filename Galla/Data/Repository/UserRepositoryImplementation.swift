//
//  UserRepositoryImplementation.swift
//  Galla
//
//  Created by Dimas Putro on 24/06/22.
//

import Foundation

class UserRepositoryImplementation: UserRepository {

  private let remoteDataSource: UserRemoteDataSourceProtocol
  private let localDataSource: UserLocalDataSourceProtocol

  init(remoteDataSource: UserRemoteDataSourceProtocol, localDataSource: UserLocalDataSourceProtocol) {
    self.remoteDataSource = remoteDataSource
    self.localDataSource = localDataSource
  }

  func register(with credentials: AuthCredential, completion: @escaping (Result<BaseResponse<User>, ResponseError>) -> ()) {
    return remoteDataSource.register(with: credentials) { result in
      switch result {
      case .success(let data):
        /// save user data
        self.saveUserData(with: data.data)
        completion(.success(data))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func login(email: String, password: String, completion: @escaping (Result<BaseResponse<User>, ResponseError>) -> ()) {
    return remoteDataSource.login(withEmail: email, withPassword: password) { result in
      switch result {
      case .success(let data):
        /// save user data
        self.saveUserData(with: data.data)
        completion(.success(data))
      case .failure(let error) :
        completion(.failure(error))
      }
    }
  }

  func logout(completion: @escaping (Result<Bool, ResponseError>) -> ()) {
    return remoteDataSource.logout { result in
      switch result {
      case .success(let data):
        completion(.success(data))
      case .failure(let error) :
        completion(.failure(error))
      }
    }
  }

  func fetchUserData(with metaCredential: MetaCredential, completion: @escaping (Result<BaseResponse<User>, ResponseError>) -> ()) {
//    let fromLocal = localDataSource.getUserData()
//
//    if !fromLocal.uid.isEmpty {
//      completion(.success(BaseResponse.init(status: true, data: fromLocal, meta: nil)))
//    }

    /// getting data from remote
    remoteDataSource.fetchUserData(withMetaCredential: metaCredential) { result in
      switch result {
      case .success(let data):
        completion(.success(data))
      case .failure(let error) :
        completion(.failure(error))
      }
    }
  }

  func saveUserData(with data: User) {
    return localDataSource.saveUserData(data)
  }

  func currentUser() -> User {
    return localDataSource.getUserData()
  }

}
