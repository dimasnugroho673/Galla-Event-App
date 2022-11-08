//
//  EventViewModel.swift
//  Galla
//
//  Created by Dimas Putro on 28/06/22.
//

class EventViewModel {

  private let eventUseCase: EventUseCase
  private let locationUseCase: LocationUseCase

  var isLoading: Observable<Bool> = Observable(false)
  var errorMessage: Observable<String> = Observable("")

  var upcomingEvents: Observable<[Event]> = Observable([Event]())
  var popularEvents: Observable<[Event]> = Observable([Event]())
  var detailEvent: Observable<DetailEvent> = Observable(DetailEvent(uid: "", name: "", description: "", dateStart: "", dateEnd: "", poster: "", ticketPrice: "", quota: 0, quotaRemaining: 0, createdAt: "", updatedAt: "", location: Location(uid: "", country: "", venue: "", fullAddress: "", latitude: "", longitude: "", province: Region(id: 0, name: ""), regency: Region(id: 0, name: "")), viewer: 0, organizer: Organizer(uid: "", name: "", organizerDescription: "", image: "", isVerified: false, organizerSector: "", createdAt: "", updatedAt: "")))
  var isFavorite: Observable<Bool> = Observable(false)
  var joinEventStatus: Observable<Bool?> = Observable(nil)
  var selectedLocation: Observable<LocationResult> = Observable(LocationResult(type: "", id: 0, name: ""))

  init(eventUseCase: EventUseCase, locationUseCase: LocationUseCase) {
    self.eventUseCase = eventUseCase
    self.locationUseCase = locationUseCase
  }

  func locationEventCustom(location: String, country: String) -> String {
    var locationNew = location
    locationNew = locationNew.replacingOccurrences(of: "KOTA ", with: "")
    locationNew = locationNew.replacingOccurrences(of: "KAB. ", with: "")
    locationNew = locationNew.capitalized

    return "\(locationNew), \(country.uppercased())"
  }

  func fetchUpcomingEvent(location: String, locationType: String) {
    eventUseCase.fetchUpcomingEvent(location: location, locationType: locationType) { result in
      switch result {
      case .success(let data):
        self.upcomingEvents.value = data.data
      case .failure(let error):
        self.errorMessage.value = error.errorDescription ?? ""
      }
    }
  }

  func fetchPopularEvent(location: String, isFinished: Bool, locationType: String) {
    eventUseCase.fetchPopularEvent(location: location, isFinished: false, locationType: locationType) { result in
      switch result {
      case .success(let data):
        self.popularEvents.value = data.data
        print(self.popularEvents.value)
      case .failure(let error):
        self.errorMessage.value = error.errorDescription ?? ""
      }
    }
  }

  func fetchDetailEvent(uid: String) {
    eventUseCase.fetchDetailEvent(uid: uid) { result in
      switch result {
      case .success(let data):
        self.detailEvent.value = data.data
      case .failure(let error):
        self.errorMessage.value = error.errorDescription ?? ""
      }
    }
  }

  func attemptJoinEvent(uid: String) {
    isLoading.value = true
    eventUseCase.joinEvent(uid: uid) { result in
      self.joinEventStatus.value = result.status
      print("DEBUG: Joined status: \(result.data)")
      self.isLoading.value = false
    }
  }

  func getSelectedLocation() {
    var savedLocation = locationUseCase.getSelectedLocation()

    // force call function after first action cannot getting location
    if savedLocation.name == "" {
      savedLocation = locationUseCase.getSelectedLocation()
    }

    self.selectedLocation.value = savedLocation
  }

  func checkFavorite(uid: String) {
    eventUseCase.checkFavorite(uid: uid) { result in
      self.isFavorite.value = result.data
    }
  }

  func addFavorite(uid: String) {
    eventUseCase.addFavorite(uid: uid) { result in
      print("DEBUG: \(result)")
      self.isFavorite.value = true
    }
  }

  func removeFavorite(uid: String) {
    eventUseCase.removeFavorite(uid: uid) { result in
      print("DEBUG: \(result)")
      self.isFavorite.value = false
    }
  }
}

