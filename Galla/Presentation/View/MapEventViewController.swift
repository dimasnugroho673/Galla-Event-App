//
//  MapEventViewController.swift
//  Galla
//
//  Created by Dimas Putro on 01/07/22.
//

import UIKit
import CoreLocation
import MapKit

class MapEventViewController: UIViewController {

  private var event: DetailEvent
  private var coordinate: CLLocationCoordinate2D

  lazy var mapView: MKMapView = {
    let map = MKMapView()
    map.translatesAutoresizingMaskIntoConstraints = false
    map.delegate = self

    return map
  }()

  lazy var backButtonNavBar: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "chevron.left")?.withTintColor(UIColor(named: "color-black")!, renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration.init(weight: UIImage.SymbolWeight.semibold)), for: .normal)
    button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    button.widthAnchor.constraint(equalToConstant: 40).isActive = true
    button.backgroundColor = .white
    button.layer.cornerRadius = 40 / 2
    button.clipsToBounds = true
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOpacity = 1
    button.layer.shadowRadius = 10
    button.layer.shadowOffset = CGSize(width: 10, height: 10)

    button.addTarget(self, action: #selector(handleBackButtonNav), for: .touchUpInside)

    return button
  }()

  init(event: DetailEvent) {
    self.event = event
    self.coordinate = CLLocationCoordinate2D(latitude: Double(event.location.latitude) ?? 0.0, longitude: Double(event.location.longitude) ?? 0.0)

    super.init(nibName: nil, bundle: nil)

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    configureUI()
    annotationGenerator(coordinate: self.coordinate, title: event.name, subtitle: "Event Location")
//    annotationGenerator(coordinate: CLLocationCoordinate2D(latitude: 0.928738, longitude: 104.443349), title: "KFC Kaca Puri", subtitle: "Fried Chicken")
  }

  private func configureUI() {
    view.addSubview(mapView)
    mapView.addSubview(backButtonNavBar)

    mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)

    NSLayoutConstraint.activate([
      mapView.topAnchor.constraint(equalTo: view.topAnchor),
      mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
      mapView.rightAnchor.constraint(equalTo: view.rightAnchor),

      backButtonNavBar.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
      backButtonNavBar.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 15),
    ])
  }

  func annotationGenerator(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
    let pin = MKPointAnnotation()
    pin.coordinate = coordinate
    pin.title = title
    pin.subtitle = subtitle

    mapView.addAnnotation(pin)
  }

  @objc func handleBackButtonNav() {
    navigationController?.popViewController(animated: true)
  }
}

extension MapEventViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard !(annotation is MKUserLocation) else { return nil }

    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "EventAnnotation")

    if annotationView == nil {
      annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "EventAnnotation")
      annotationView?.canShowCallout = true
      annotationView?.rightCalloutAccessoryView
    } else {
      annotationView?.annotation = annotation
    }

    annotationView?.image = UIImage(named: "icon-location-pin")

//    let tap = UIGestureRecognizer(target: self, action: #selector(handleAnnotationTap))

    return annotationView
  }
}
