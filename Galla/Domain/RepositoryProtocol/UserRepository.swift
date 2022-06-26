//
//  UserRepository.swift
//  Galla
//
//  Created by Dimas Putro on 24/06/22.
//

protocol UserRepository {
  func register(with credentials: AuthCredential, completion: @escaping(Result<BaseResponse<User>, ResponseError>) -> ())
  func login(email: String, password: String, completion: @escaping(Result<BaseResponse<User>, ResponseError>) -> ())
  func logout(completion: @escaping(Result<Bool, ResponseError>) -> ())
  func fetchUserData(with metaCredential: MetaCredential, completion: @escaping(Result<BaseResponse<User>, ResponseError>) -> ())
  func saveUserData(with data: User)
}
