//
//  TicketRemoteDataSourceProtocol.swift
//  Galla
//
//  Created by Dimas Putro on 15/08/22.
//

protocol TicketRemoteDataSourceProtocol {
  func getAll(isCanceled: Bool?, completion: @escaping(Result<BaseResponse<[Ticket]>, ResponseError>) -> ())
}
