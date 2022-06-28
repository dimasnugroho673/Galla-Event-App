//
//  Event.swift
//  Galla
//
//  Created by Dimas Putro on 28/06/22.
//

import Foundation

// MARK: - Event
struct Event: Codable {
  let uid, name, dateStart, dateEnd: String
  let poster: String
  let ticketPrice: String
  let quota, quotaRemaining: Int
  let createdAt, updatedAt: String
  let location: Location
  let viewer: Int

  enum CodingKeys: String, CodingKey {
    case uid, name
    case dateStart = "date_start"
    case dateEnd = "date_end"
    case poster
    case ticketPrice = "ticket_price"
    case quota
    case quotaRemaining = "quota_remaining"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case location, viewer
  }
}

// MARK: - Detail Event
struct DetailEvent: Codable {
  let uid, name, description, dateStart, dateEnd: String
  let poster: String
  let ticketPrice: String
  let quota, quotaRemaining: Int
  let createdAt, updatedAt: String
  let location: Location
  let viewer: Int
  let organizer: Organizer

  enum CodingKeys: String, CodingKey {
    case uid, name, description
    case dateStart = "date_start"
    case dateEnd = "date_end"
    case poster
    case ticketPrice = "ticket_price"
    case quota
    case quotaRemaining = "quota_remaining"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case location, viewer, organizer
  }
}

// MARK: - Location
struct Location: Codable {
  let uid, country, venue, fullAddress: String
  let latitude, longitude: String
  let province, regency: Region

  enum CodingKeys: String, CodingKey {
    case uid, country, venue
    case fullAddress = "full_address"
    case latitude, longitude, province, regency
  }
}

// MARK: - Province
struct Region: Codable {
  let id: Int
  let name: String
}


// MARK: - Organizer
struct Organizer: Codable {
  let uid, name, organizerDescription: String
  let image: String
  let isVerified: Bool
  let createdAt, updatedAt: String

  enum CodingKeys: String, CodingKey {
    case uid, name
    case organizerDescription = "description"
    case image
    case isVerified = "is_verified"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
  }
}
