//
//  SearchEventViewModel.swift
//  Galla
//
//  Created by Dimas Putro on 21/08/22.
//

class SearchEventViewModel {

  private let eventService: EventService

  var isLoading: Observable<Bool> = Observable(false)
  var errorMessage: Observable<String> = Observable("")

  var resultEvents: Observable<[Event]> = Observable([Event]())

  init(eventService: EventService) {
    self.eventService = eventService
  }

  func searchEvent(keyword: String) {
    self.isLoading.value = true

    eventService.search(keyword: keyword, location: nil, locationType: nil, isFinished: nil) { result in
      switch result {
      case .success(let data):
        self.resultEvents.value = data.data
        self.isLoading.value.toggle()
      case .failure(let error):
        self.errorMessage.value = error.errorDescription ?? ""
      }
    }
  }
}

