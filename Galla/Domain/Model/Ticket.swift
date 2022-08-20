//
//  Ticket.swift
//  Galla
//
//  Created by Dimas Putro on 15/08/22.
//

// MARK: - Ticket
struct Ticket: Codable {
  let uid, name, dateStart, dateEnd: String
  let ticketPrice: String
  let createdAt, updatedAt: String
  let transactionCode: String
  let location: Location

  enum CodingKeys: String, CodingKey {
    case uid, name
    case dateStart = "date_start"
    case dateEnd = "date_end"
    case ticketPrice = "ticket_price"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case transactionCode = "transaction_code"
    case location
  }
}
