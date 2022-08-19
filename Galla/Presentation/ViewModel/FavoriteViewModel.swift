//
//  FavoriteViewModel.swift
//  Galla
//
//  Created by Dimas Putro on 19/08/22.
//

class FavoriteViewModel {

  private var eventService: EventService

  var isLoading: Observable<Bool> = Observable(false)
  var errorMessage: Observable<String> = Observable("")

  var favorites: Observable<[Event]> = Observable([Event]())

  init(eventService: EventService) {
    self.eventService = eventService
  }

  func fetchFavorite() {
    eventService.fetchFavoriteEvent { result in
      switch result {
      case .success(let data):
        self.favorites.value = data.data
      case .failure(let error):
        self.errorMessage.value = error.errorDescription ?? ""
      }
    }
  }

}
