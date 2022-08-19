//
//  TicketViewModel.swift
//  Galla
//
//  Created by Dimas Putro on 15/08/22.
//

class TicketViewModel {

  private let ticketService: TicketService

  var tickets: Observable<[Ticket]> = Observable([Ticket]())
  
  var isLoading: Observable<Bool> = Observable(false)
  var errorMessage: Observable<String> = Observable("")

  init(ticketService: TicketService) {
    self.ticketService = ticketService
  }

  func getAll(isCanceled: Bool?) {
    return ticketService.getAll(isCanceled: isCanceled) { result in
      switch result {
      case .success(let data):
        self.tickets.value = data.data
      case .failure(let error):
        self.errorMessage.value = error.errorDescription ?? ""
      }
    }
  }

}
