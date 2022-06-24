//
//  Error.swift
//  Galla
//
//  Created by Dimas Putro on 24/06/22.
//

import Foundation

enum ResponseError: Error {
  case validationError
  case errorFetchingData
  case credentialsCannotEmpty
  case errorFromAPI(String)
  case customError(String)

  var errorDescription: String? {
    switch self {
    case .validationError:
      return "Validation error"
    case .errorFetchingData:
      return "Error while getting data"
    case .credentialsCannotEmpty:
      return "All field cannot empty"
    case .errorFromAPI(let error):
      return error
    case .customError(let string):
      return string
    }
  }
}
