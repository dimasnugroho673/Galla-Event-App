//
//  TicketViewModel.swift
//  Galla
//
//  Created by Dimas Putro on 15/08/22.
//

import Foundation

class TicketViewModel {

  private let ticketUseCase: TicketUseCase

  var tickets: Observable<[Ticket]> = Observable([Ticket]())
  private var unfilteredTickets: [Ticket] = [Ticket]()
  
  var isLoading: Observable<Bool> = Observable(false)
  var errorMessage: Observable<String> = Observable("")

  init(ticketUseCase: TicketUseCase) {
    self.ticketUseCase = ticketUseCase
  }

  func getAll(refresh: Bool = false, isCanceled: Bool?) {
    isLoading.value = refresh ? false : true

    return ticketUseCase.getAll(isCanceled: isCanceled) { result in
      switch result {
      case .success(let data):
        self.unfilteredTickets = data.data

        let now = Date().timeIntervalSince1970

        _ = data.data.map { ticket in
          let dateEnd = ticket.dateEnd.toSecond(timeZone: "Asia/Jakarta")!

          if now <= dateEnd && !ticket.isCanceled {
            self.tickets.value.append(ticket)
          }
        }

        self.isLoading.value = false
      case .failure(let error):
        self.errorMessage.value = error.errorDescription ?? ""
      }
    }
  }

  func filter(type: String) {
    let now = Date().timeIntervalSince1970

    self.tickets.value.removeAll()

    if type == "Ongoing" {
      _ = unfilteredTickets.map { ticket in
        let dateEnd = ticket.dateEnd.toSecond(timeZone: "Asia/Jakarta")!

        if now <= dateEnd && !ticket.isCanceled {
          self.tickets.value.append(ticket)
        }
      }
    } else if type == "All" {
      _ = unfilteredTickets.map { ticket in
        let dateEnd = ticket.dateEnd.toSecond(timeZone: "Asia/Jakarta")!

        if  now <= dateEnd {
          self.tickets.value.append(ticket)
        }
      }
    } else if type == "Canceled" {
      _ = unfilteredTickets.map { ticket in
        if ticket.isCanceled {
          self.tickets.value.append(ticket)
        }
      }
    }
  }

}
