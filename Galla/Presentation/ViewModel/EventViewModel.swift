//
//  EventViewModel.swift
//  Galla
//
//  Created by Dimas Putro on 28/06/22.
//

class EventViewModel {

  private let eventService: EventService
  private let locationService: LocationService

  var isLoading: Observable<Bool> = Observable(false)
  var errorMessage: Observable<String> = Observable("")

  var upcomingEvents: Observable<[Event]> = Observable([Event]())
  var popularEvents: Observable<[Event]> = Observable([Event]())
  var detailEvent: Observable<DetailEvent> = Observable(DetailEvent(uid: "", name: "", description: "", dateStart: "", dateEnd: "", poster: "", ticketPrice: "", quota: 0, quotaRemaining: 0, createdAt: "", updatedAt: "", location: Location(uid: "", country: "", venue: "", fullAddress: "", latitude: "", longitude: "", province: Region(id: 0, name: ""), regency: Region(id: 0, name: "")), viewer: 0, organizer: Organizer(uid: "", name: "", organizerDescription: "", image: "", isVerified: false, organizerSector: "", createdAt: "", updatedAt: "")))
  var joinEventStatus: Observable<Bool> = Observable(false)
  var selectedLocation: Observable<LocationResult> = Observable(LocationResult(type: "", id: 0, name: ""))

  init(eventService: EventService, locationService: LocationService) {
    self.eventService = eventService
    self.locationService = locationService
  }

  func locationEventCustom(location: String, country: String) -> String {
    var locationNew = location
    locationNew = locationNew.replacingOccurrences(of: "KOTA ", with: "")
    locationNew = locationNew.replacingOccurrences(of: "KAB. ", with: "")
    locationNew = locationNew.capitalized

    return "\(locationNew), \(country.uppercased())"
  }

  func fetchUpcomingEvent(location: String) {
    eventService.fetchUpcomingEvent(location: "tanjung pinang", locationType: "regency") { result in
      switch result {
      case .success(let data):
        self.upcomingEvents.value = data.data
      case .failure(let error):
        self.errorMessage.value = error.errorDescription ?? ""
      }
    }
  }

  func fetchPopularEvent(location: String, isFinished: Bool) {
    eventService.fetchPopularEvent(location: "bintan", isFinished: false) { result in
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
    eventService.fetchDetailEvent(uid: uid) { result in
      switch result {
      case .success(let data):
        self.detailEvent.value = data.data
        print("DETAIL...\(String(describing:  self.detailEvent.value))")
      case .failure(let error):
        self.errorMessage.value = error.errorDescription ?? ""
      }
    }
  }

  func attemptJoinEvent(uid: String) {
    isLoading.value = true
    eventService.joinEvent(uid: uid) { result in
      self.joinEventStatus.value = result.status
      self.isLoading.value = false
    }
  }

  func getSelectedLocation() {
    let savedLocation = locationService.getSelectedLocation()

    self.selectedLocation.value = savedLocation
  }
}

