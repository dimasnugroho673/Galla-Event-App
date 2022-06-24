//
//  UserRepositoryImplementation.swift
//  Galla
//
//  Created by Dimas Putro on 24/06/22.
//

class UserRepositoryImplementation: UserRepository {

  private let dataSource: UserRemoteDataSource

  init(dataSource: UserRemoteDataSource) {
    self.dataSource = dataSource
  }

  func register(with credentials: AuthCredential, completion: @escaping (Result<BaseResponse<User>, ResponseError>) -> ()) {
    return dataSource.register(with: credentials) { result in
      switch result {
      case .success(let data):
        completion(.success(data))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func login(email: String, password: String, completion: @escaping (Result<BaseResponse<User>, ResponseError>) -> ()) {
    return dataSource.login(withEmail: email, withPassword: password) { result in
      switch result {
      case .success(let data):
        completion(.success(data))
      case .failure(let error) :
        completion(.failure(error))
      }
    }
  }

  func logout(completion: @escaping (Result<Bool, ResponseError>) -> ()) {
    return dataSource.logout { result in
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

}
