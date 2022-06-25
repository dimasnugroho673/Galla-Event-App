//
//  BaseResponse.swift
//  Galla
//
//  Created by Dimas Putro on 24/06/22.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
  let status: Bool
  let data: T
  let meta: MetaCredential?
}

struct ValidationResponse<T: Any>: Codable {
  let T: [String]
}
