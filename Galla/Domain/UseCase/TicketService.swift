//
//  TicketService.swift
//  Galla
//
//  Created by Dimas Putro on 15/08/22.
//

class TicketService: TicketUseCase {

  private let repository: TicketRepository

  init(repository: TicketRepository) {
    self.repository = repository
  }

  func getAll(isCanceled: Bool?, completion: @escaping (Result<BaseResponse<[Ticket]>, ResponseError>) -> ()) {
    return repository.getAll(isCanceled: isCanceled) { result in
      switch result {
      case .success(let data):
        completion(.success(data))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
