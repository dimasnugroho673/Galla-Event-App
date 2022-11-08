//
//  FavoriteViewModel.swift
//  Galla
//
//  Created by Dimas Putro on 19/08/22.
//

class FavoriteViewModel {

  private var eventUseCase: EventUseCase

  var isLoading: Observable<Bool> = Observable(false)
  var errorMessage: Observable<String> = Observable("")

  var favorites: Observable<[Event]> = Observable([Event]())

  init(eventUseCase: EventUseCase) {
    self.eventUseCase = eventUseCase
  }

  func fetchFavorite(refresh: Bool = false) {
    isLoading.value = refresh ? false : true

    eventUseCase.fetchFavoriteEvent { result in
      switch result {
      case .success(let data):
        self.favorites.value = data.data
        self.isLoading.value = false
      case .failure(let error):
        self.errorMessage.value = error.errorDescription ?? ""
      }
    }
  }

}
