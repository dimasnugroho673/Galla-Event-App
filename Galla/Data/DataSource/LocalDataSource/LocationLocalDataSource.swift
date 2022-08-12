//
//  LocationLocalDataSource.swift
//  Galla
//
//  Created by Dimas Putro on 10/08/22.
//

import Foundation

final class LocationLocalDataSource: LocationLocalDataSourceProtocol {
  func getSelectedLocation() -> LocationResult {

    var location: LocationResult?

    do {
      let retriveData = UserDefaults.standard.data(forKey: "LocalLocationData")

      if (retriveData != nil) {
        let decode = try JSONDecoder().decode(LocationResult.self, from: retriveData!)

        location = decode
      } else {
        location = LocationResult(type: "", id: "", name: "")
      }

    } catch {
      print("DEBUG: Error while retrive user data: persistent data not configure")
    }

    return location!
  }

  func saveSelectedLocation(_ data: LocationResult) {
    do {
      let encode = try JSONEncoder().encode(data)

      UserDefaults.standard.set(encode, forKey: "LocalLocationData")
    } catch {
      fatalError("DEBUG: Error while saving location current data: persistent data not configure")
    }
  }
}
