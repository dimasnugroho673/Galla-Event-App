//
//  LocationLocalDataSourceProtocol.swift
//  Galla
//
//  Created by Dimas Putro on 10/08/22.
//

protocol LocationLocalDataSourceProtocol {
  func getSelectedLocation() -> LocationResult
  func saveSelectedLocation(_ data: LocationResult)
}
