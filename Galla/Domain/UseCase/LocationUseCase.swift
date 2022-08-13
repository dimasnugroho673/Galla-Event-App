//
//  LocationUseCase.swift
//  Galla
//
//  Created by Dimas Putro on 12/08/22.
//

import Foundation

protocol LocationUseCase {
  func search(_ keyword: String, completion: @escaping(Result<BaseResponse<[LocationResult]>, ResponseError>) -> ())
  func getSelectedLocation() -> LocationResult
  func saveSelectedLocation(_ data: LocationResult)
}
