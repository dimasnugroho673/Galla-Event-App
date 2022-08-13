//
//  LocationRemoteDataSourceProtocol.swift
//  Galla
//
//  Created by Dimas Putro on 12/08/22.
//

protocol LocationRemoteDataSourceProtocol {
  func search(_ keyword: String, completion: @escaping(Result<BaseResponse<[LocationResult]>, ResponseError>) -> ())
}
