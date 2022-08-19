//
//  TicketRepositoryImplementation.swift
//  Galla
//
//  Created by Dimas Putro on 15/08/22.
//

class TicketRepositoryImplementation: TicketRepository {

  private let remoteDataSource: TicketRemoteDataSourceProtocol
  private let localDataSource: TicketLocalDataSourceProtocol

  init(remoteDataSource: TicketRemoteDataSourceProtocol, localDataSource: TicketLocalDataSourceProtocol) {
    self.remoteDataSource = remoteDataSource
    self.localDataSource = localDataSource
  }

  func getAll(isCanceled: Bool?, completion: @escaping (Result<BaseResponse<[Ticket]>, ResponseError>) -> ()) {
    return remoteDataSource.getAll(isCanceled: isCanceled) { result in
      switch result {
      case .success(let data):
        completion(.success(data))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

}
