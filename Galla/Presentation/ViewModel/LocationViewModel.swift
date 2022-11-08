//
//  LocationViewModel.swift
//  Galla
//
//  Created by Dimas Putro on 10/08/22.
//

import Dispatch

class LocationViewModel {

  private var locationUseCase: LocationUseCase

  var isLoading: Observable<Bool> = Observable(false)
  var errorMessage: Observable<String> = Observable("")

  var searchTask: DispatchWorkItem?

  init(locationUseCase: LocationUseCase) {
    self.locationUseCase = locationUseCase
  }

  var locations: Observable<[LocationResult]> = Observable([LocationResult]())

  func attemptSearch(_ keyword: String) {
    let keyword = keyword.replacingOccurrences(of: " ", with: "+")

    self.searchTask?.cancel()

    let task = DispatchWorkItem { [weak self] in
      DispatchQueue.global(qos: .userInteractive).async { [weak self] in
        self?.locationUseCase.search(keyword) { result in
          switch result {
          case .success(let data):
            print(data)
            self?.locations.value = data.data
          case .failure(let error):
            self?.errorMessage.value = error.errorDescription ?? ""
          }
        }
      }
    }

    self.searchTask = task

    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8, execute: task)

  }

  func saveSelectedLocation(_ data: LocationResult) {
    locationUseCase.saveSelectedLocation(data)
  }
  
}
