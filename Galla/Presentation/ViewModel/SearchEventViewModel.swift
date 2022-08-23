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
  var joinEventStatus: Observable<Bool> = Observable(false)

  var resultEvents: Observable<[Event]> = Observable([Event]())

  init(eventService: EventService) {
    self.eventService = eventService
  }

  func searchEvent(refresh: Bool = false, keyword: String) {
    isLoading.value = refresh ? false : true

    eventService.search(keyword: keyword, location: nil, locationType: nil, isFinished: nil) { result in
      switch result {
      case .success(let data):
        self.resultEvents.value = data.data
        self.isLoading.value = false
      case .failure(let error):
        self.errorMessage.value = error.errorDescription ?? ""
      }
    }
  }

  func attemptJoinEvent(uid: String) {
    eventService.joinEvent(uid: uid) { result in
      self.joinEventStatus.value = result.status
      print("DEBUG: Joined status: \(result.data)")
    }
  }
}

