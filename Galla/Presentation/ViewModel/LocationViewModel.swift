//
//  LocationViewModel.swift
//  Galla
//
//  Created by Dimas Putro on 10/08/22.
//

import Dispatch

class LocationViewModel {

  private var locationService: LocationService

  var isLoading: Observable<Bool> = Observable(false)
  var errorMessage: Observable<String> = Observable("")

  var searchTask: DispatchWorkItem?

  init(locationService: LocationService) {
    self.locationService = locationService
  }

  var locations: Observable<[LocationResult]> = Observable([
    LocationResult(type: "province", id: "11", name: "Aceh"),
    LocationResult(type: "regency", id: "1101", name: "Aceh Selatan"),
    LocationResult(type: "regency", id: "1102", name: "Aceh Tenggara"),
    LocationResult(type: "regency", id: "1103", name: "Aceh Timur"),
    LocationResult(type: "regency", id: "1104", name: "Aceh Tengah"),
  ])

  func attemptSearch(_ keyword: String) {
    guard keyword != "" else { return }

    self.searchTask?.cancel()

    let task = DispatchWorkItem { [weak self] in
      DispatchQueue.global(qos: .userInteractive).async { [weak self] in
        self?.locationService.search(keyword) { result in
          switch result {
          case .success(let data):
            print(data)
          case .failure(let error):
            self?.errorMessage.value = error.errorDescription ?? ""
          }
        }
      }
    }

    self.searchTask = task

    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8, execute: task)

  }
  
}
