//
//  UserRemoteDataSourceProtocol.swift
//  Galla
//
//  Created by Dimas Putro on 13/07/22.
//

import Foundation

protocol UserRemoteDataSourceProtocol {
  func register(with credentials: AuthCredential, completion: @escaping (Result<BaseResponse<User>, ResponseError>) -> ())
  func login(withEmail email: String, withPassword password: String, completion: @escaping (Result<BaseResponse<User>, ResponseError>) -> ())
  func logout(completion: @escaping (Result<Bool, ResponseError>) -> ())
  func fetchUserData(withMetaCredential metaCredential: MetaCredential, completion: @escaping (Result<BaseResponse<User>, ResponseError>) -> ())
}
