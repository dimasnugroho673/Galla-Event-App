//
//  UserRepositoryImplementation.swift
//  Galla
//
//  Created by Dimas Putro on 24/06/22.
//

class UserRepositoryImplementation: UserRepository {

  private let remoteDataSource: UserRemoteDataSource
  private let localDataSource: UserLocalDataSource

  init(remoteDataSource: UserRemoteDataSource, localDataSource: UserLocalDataSource) {
    self.remoteDataSource = remoteDataSource
    self.localDataSource = localDataSource
  }

  func register(with credentials: AuthCredential, completion: @escaping (Result<BaseResponse<User>, ResponseError>) -> ()) {
    return remoteDataSource.register(with: credentials) { result in
      switch result {
      case .success(let data):
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

//  func fetchUserData(with metaCredential: MetaCredential, completion: @escaping (Result<BaseResponse<User>, ResponseError>) -> ()) {
//    return dataSource.fetchUserData(withMetaCredential: metaCredential) { result in
//      switch result {
//      case .success(let data):
//        completion(.success(data))
//      case .failure(let error) :
//        completion(.failure(error))
//      }
//    }
//  }

  func saveUserData(with data: User) {
    return localDataSource.saveUserData(data)
  }

}
