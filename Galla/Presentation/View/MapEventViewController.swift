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
    button.layer.shadowRadius = 13
    button.layer.shadowOffset = CGSize(width: 10, height: 10)

    button.addTarget(self, action: #selector(handleBackButtonNav), for: .touchUpInside)

    return button
  }()

  lazy var bottomStickyView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.heightAnchor.constraint(equalToConstant: 130).isActive = true
    view.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
    view.layer.shadowColor = UIColor(hexString: "EFEFEF").cgColor
    view.layer.shadowOpacity = 1
    view.layer.shadowRadius = 30
    view.layer.shadowOffset = CGSize(width: 10, height: 10)

    return view
  }()

  lazy var openInMap: UIButton = CTAButton(title: "Open In Maps")

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

    // this can multiple annotation
    annotationGenerator(coordinate: self.coordinate, title: event.name, subtitle: "Event Location")
  }

  private func configureUI() {
    view.addSubview(mapView)
    mapView.addSubview(backButtonNavBar)
    mapView.addSubview(bottomStickyView)
    bottomStickyView.addSubview(openInMap)
    openInMap.backgroundColor = .systemBlue
    openInMap.addTarget(self, action: #selector(askToOpenMap), for: .touchUpInside)

    mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)

    NSLayoutConstraint.activate([
      mapView.topAnchor.constraint(equalTo: view.topAnchor),
      mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
      mapView.rightAnchor.constraint(equalTo: view.rightAnchor),

      backButtonNavBar.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
      backButtonNavBar.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 15),

      bottomStickyView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor),
      bottomStickyView.leftAnchor.constraint(equalTo: mapView.leftAnchor),
      bottomStickyView.rightAnchor.constraint(equalTo: mapView.rightAnchor),

      openInMap.leftAnchor.constraint(equalTo: bottomStickyView.leftAnchor, constant: 15),
      openInMap.rightAnchor.constraint(equalTo: bottomStickyView.rightAnchor, constant: -15),
      openInMap.topAnchor.constraint(equalTo: bottomStickyView.topAnchor, constant: 15)
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

  @objc func askToOpenMap() {
    OpenMapDirections.present(in: self, sourceView: openInMap, coordinate: coordinate)
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

    let tap = UITapGestureRecognizer(target: self, action: #selector(handleAnnotationTap(_:)))
    annotationView?.addGestureRecognizer(tap)
    annotationView?.isUserInteractionEnabled = true

    return annotationView
  }

  @objc func handleAnnotationTap(_ sender: MKAnnotationView) {
    print("tapped....")
  }
}
