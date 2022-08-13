//
//  DetailEventViewController.swift
//  Galla
//
//  Created by Dimas Putro on 28/06/22.
//

import UIKit
import SDWebImage

class DetailEventViewController: UIViewController {

  private let eventViewModel: EventViewModel = EventViewModel(eventService: Injection().provideDetail(), locationService: Injection().provideSearch())

  private let uid: String
  private let data: Event

  lazy var scrollView: UIScrollView = {
    let sv = UIScrollView(frame: .zero)
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.bounces = true
    sv.backgroundColor = UIColor(named: "color-background")
    sv.autoresizingMask = .flexibleHeight

    return sv
  }()

  lazy var containerView: UIView = {
    let sv = UIView()
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.backgroundColor = UIColor(named: "color-background")
    sv.autoresizingMask = .flexibleHeight

    return sv
  }()

  lazy var navBarView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.heightAnchor.constraint(equalToConstant: 91).isActive = true
    view.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true

    return view
  }()

  lazy var bottomStickyView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.heightAnchor.constraint(equalToConstant: 121).isActive = true
    view.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
    view.layer.shadowColor = UIColor(hexString: "EFEFEF").cgColor
    view.layer.shadowOpacity = 1
    view.layer.shadowRadius = 30
    view.layer.shadowOffset = CGSize(width: 10, height: 10)

    return view
  }()

  lazy var backButtonNavBar: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "chevron.left")?.withTintColor(UIColor(named: "color-black")!, renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration.init(weight: UIImage.SymbolWeight.semibold)), for: .normal)
    button.heightAnchor.constraint(equalToConstant: 22).isActive = true
    button.widthAnchor.constraint(equalToConstant: 22).isActive = true

    button.addTarget(self, action: #selector(handleBackButtonNav), for: .touchUpInside)

    return button
  }()

  lazy var titleNavBar: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Detail Event"
    label.textColor = UIColor(named: "color-black")
    label.font = UIFont(name: "Poppins-SemiBold", size: 14)

    return label
  }()

  lazy var shareButtonNavBar: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "square.and.arrow.up")?.withTintColor(UIColor(named: "color-black")!, renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration.init(weight: UIImage.SymbolWeight.semibold)), for: .normal)
    button.heightAnchor.constraint(equalToConstant: 22).isActive = true
    button.widthAnchor.constraint(equalToConstant: 22).isActive = true

    return button
  }()

  lazy var posterImageView: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.heightAnchor.constraint(equalToConstant: 210).isActive = true
    iv.image = UIImage(named: "dummy-poster")
    iv.contentMode = .scaleAspectFill
    iv.layer.cornerRadius = 12
    iv.clipsToBounds = true

    return iv
  }()

  lazy var freeLabel: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor(hexString: "FFEDE9")
    view.layer.cornerRadius = 8
    view.heightAnchor.constraint(equalToConstant: 35).isActive = true
    view.widthAnchor.constraint(equalToConstant: 60).isActive = true

    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Free"
    label.font = UIFont(name: "Poppins-Medium", size: 14)
    label.textColor = UIColor(named: "color-primary")

    view.addSubview(label)
    label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    return view
  }()

  lazy var eventNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Dancing in The Moon"
    label.font = UIFont(name: "Poppins-SemiBold", size: 16)
    label.textColor = UIColor(named: "color-black")
    label.textAlignment = .justified
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping

    return label
  }()

  lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "9 Agustus 2022 • 17:00"
    label.font = UIFont(name: "Poppins-Regular", size: 12)
    label.textColor = .systemGray

    return label
  }()

  lazy var locationIconImage: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.widthAnchor.constraint(equalToConstant: 12).isActive = true
    iv.heightAnchor.constraint(equalToConstant: 13.65).isActive = true
    iv.image = UIImage(named: "icon-location")

    return iv
  }()

  lazy var locationLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Bandung, ID"
    label.font = UIFont(name: "Poppins-Regular", size: 12)
    label.textColor = .systemGray

    return label
  }()

  lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: "Poppins-Regular", size: 13)
    label.textColor = UIColor(hexString: "323232")
    label.text = ""
    label.textAlignment = .justified
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping

    return label
  }()

  //  lazy var viewLocationButton: UIButton = {
  //    let button = UIButton(type: .system)
  //    button.setTitle("View Location", for: .normal)
  //    button.titleLabel?.textColor = .red
  //    button.addTarget(self, action: #selector(handleViewLocationTap), for: .touchUpInside)
  //
  //    return button
  //  }()

  //  lazy var viewLocationButton: CTAButton = CTAButton(title: "View Location")

  lazy var viewLocationView: UIView = {
    let uv = UIView()
    uv.translatesAutoresizingMaskIntoConstraints = false
    uv.heightAnchor.constraint(equalToConstant: 52).isActive = true
    uv.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
    uv.backgroundColor = .white
    uv.layer.cornerRadius = 12
    uv.layer.shadowColor = UIColor(hexString: "F4F4F4").cgColor
    uv.layer.shadowOpacity = 1
    uv.layer.shadowRadius = 30
    uv.layer.shadowOffset = CGSize(width: 10, height: 10)

    let mapImage = UIImageView()
    mapImage.translatesAutoresizingMaskIntoConstraints = false
    mapImage.image = UIImage(systemName: "mappin.circle.fill")
    mapImage.heightAnchor.constraint(equalToConstant: 28).isActive = true
    mapImage.widthAnchor.constraint(equalToConstant: 28).isActive = true
    mapImage.contentMode = .scaleAspectFill
    mapImage.tintColor = .systemRed

    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "View Location"
    label.font = UIFont(name: "Poppins-Bold", size: 14)
    label.textColor = UIColor(named: "color-black")

    let chevron = UIImageView()
    chevron.translatesAutoresizingMaskIntoConstraints = false
    chevron.image = UIImage(systemName: "chevron.forward", withConfiguration: UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.bold))
    chevron.heightAnchor.constraint(equalToConstant: 18).isActive = true
    chevron.tintColor = .systemGray

    uv.addSubview(mapImage)
    uv.addSubview(label)
    uv.addSubview(chevron)

    NSLayoutConstraint.activate([
      mapImage.leftAnchor.constraint(equalTo: uv.leftAnchor, constant: 15),
      mapImage.centerYAnchor.constraint(equalTo: uv.centerYAnchor),

      label.leftAnchor.constraint(equalTo: mapImage.rightAnchor, constant: 10),
      label.centerYAnchor.constraint(equalTo: uv.centerYAnchor),

      chevron.rightAnchor.constraint(equalTo: uv.rightAnchor, constant: -15),
      chevron.centerYAnchor.constraint(equalTo: uv.centerYAnchor)
    ])

    uv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleViewLocationTap)))

    return uv
  }()

  lazy var organizerBgView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.heightAnchor.constraint(equalToConstant: 95).isActive = true
    view.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
    view.layer.cornerRadius = 12
    view.clipsToBounds = true
    view.layer.shadowColor = UIColor(hexString: "F4F4F4").cgColor
    view.layer.shadowOpacity = 1
    view.layer.shadowRadius = 30
    view.layer.shadowOffset = CGSize(width: 10, height: 10)

    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Penyelenggara acara"
    label.textColor = .systemGray
    label.font = UIFont(name: "Poppins-Medium", size: 12)

    view.addSubview(label)
    label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
    label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true

    return view
  }()

  lazy var organizerImage: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.heightAnchor.constraint(equalToConstant: 50).isActive = true
    image.widthAnchor.constraint(equalToConstant: 50).isActive = true
    image.contentMode = .scaleAspectFill
    image.layer.cornerRadius = 50 / 2
    image.clipsToBounds = true
    image.backgroundColor = .systemGray3

    return image
  }()

  lazy var organizerNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor(named: "color-black")
    label.font = UIFont(name: "Poppins-Bold", size: 12)

    return label
  }()

  lazy var organizerVerifiedImage: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.heightAnchor.constraint(equalToConstant: 13.43).isActive = true
    image.widthAnchor.constraint(equalToConstant: 13.43).isActive = true
    image.image = UIImage(systemName: "checkmark.seal.fill")?.withTintColor(UIColor(hexString: "045AFF"), renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration.init(weight: UIImage.SymbolWeight.bold))
    image.contentMode = .scaleAspectFill

    return image
  }()

  lazy var organizerSectorLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .systemGray
    label.font = UIFont(name: "Poppins-Regular", size: 11)

    return label
  }()

  lazy var joinButton: UIButton = CTAButton(title: "Join Event")

  lazy var favoriteImage: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "heart")?.withTintColor(.systemGray3, renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration.init(weight: UIImage.SymbolWeight.light)), for: .normal)
    button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    button.widthAnchor.constraint(equalToConstant: 45).isActive = true
    button.contentHorizontalAlignment = .fill
    button.contentVerticalAlignment = .fill
//    button.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)

    button.addTarget(self, action: #selector(handleFavoriteButtonTap), for: .touchUpInside)

    return button

//    let iv = UIImageView()
//    iv.translatesAutoresizingMaskIntoConstraints = false
//    iv.image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration.init(weight: UIImage.SymbolWeight.light))
//    iv.tintColor = .systemGray3
//    iv.heightAnchor.constraint(equalToConstant: 43).isActive = true
//    iv.widthAnchor.constraint(equalToConstant: 43).isActive = true
//
//    return iv
  }()

  init(uid: String, data: Event) {
    self.uid = uid
    self.data = data

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    configureUI()
    fetchDetail()
    configureBinding()
  }

  func configureUI() {
    view.addSubview(scrollView)
    scrollView.addSubview(containerView)
    view.addSubview(navBarView)
    view.addSubview(bottomStickyView)
//    bottomStickyView.addSubview(joinButton)
//    bottomStickyView.addSubview(favoriteImage)

    joinButton.addTarget(self, action: #selector(handleJoinButtonTap), for: .touchUpInside)

    let navBarStack = UIStackView(arrangedSubviews: [backButtonNavBar, titleNavBar, shareButtonNavBar])
    navBarStack.translatesAutoresizingMaskIntoConstraints = false
    navBarStack.axis = .horizontal
    navBarStack.alignment = .center
    navBarStack.distribution = .equalSpacing

    navBarView.addSubview(navBarStack)

    let locationStack = UIStackView(arrangedSubviews: [locationIconImage, locationLabel])
    locationStack.translatesAutoresizingMaskIntoConstraints = false
    locationStack.axis = .horizontal
    locationStack.spacing = 5

    let organizerNameStack = UIStackView(arrangedSubviews: [organizerNameLabel, organizerVerifiedImage])
    organizerNameStack.translatesAutoresizingMaskIntoConstraints = false
    organizerNameStack.axis = .horizontal
    organizerNameStack.spacing = 5

    let bottomStack = UIStackView(arrangedSubviews: [joinButton, favoriteImage])
    bottomStack.translatesAutoresizingMaskIntoConstraints = false
    bottomStack.heightAnchor.constraint(equalToConstant: 45).isActive = true
    bottomStack.axis = .horizontal
    bottomStack.spacing = 10

    bottomStickyView.addSubview(bottomStack)

    containerView.addSubview(posterImageView)
    posterImageView.addSubview(freeLabel)
    containerView.addSubview(eventNameLabel)
    containerView.addSubview(dateLabel)
    containerView.addSubview(locationStack)
    containerView.addSubview(descriptionLabel)
    containerView.addSubview(viewLocationView)
    containerView.addSubview(organizerBgView)
    organizerBgView.addSubview(organizerImage)
    organizerBgView.addSubview(organizerNameStack)
    organizerBgView.addSubview(organizerSectorLabel)

    organizerVerifiedImage.isHidden = true

    NSLayoutConstraint.activate([
      navBarView.topAnchor.constraint(equalTo: view.topAnchor),
      navBarView.leftAnchor.constraint(equalTo: view.leftAnchor),
      navBarView.rightAnchor.constraint(equalTo: view.rightAnchor),

      navBarStack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5),
      navBarStack.leftAnchor.constraint(equalTo: navBarView.leftAnchor, constant: 15),
      navBarStack.rightAnchor.constraint(equalTo: navBarView.rightAnchor, constant: -15),

      bottomStickyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      bottomStickyView.leftAnchor.constraint(equalTo: view.leftAnchor),
      bottomStickyView.rightAnchor.constraint(equalTo: view.rightAnchor),

      scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
      scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
      scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),

      containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
      containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
      containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0),
      containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0),
      containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

      posterImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 60),
      posterImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
      posterImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),

      freeLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -10),
      freeLabel.rightAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: -10),

      eventNameLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
      eventNameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
      eventNameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),

      dateLabel.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 5),
      dateLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
      dateLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),

      locationStack.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 6),
      locationStack.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
      locationStack.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),

      descriptionLabel.topAnchor.constraint(equalTo: locationStack.bottomAnchor, constant: 10),
      descriptionLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
      descriptionLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),
      //      descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -(125)),

      //      viewLocationButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
      //      viewLocationButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
      //      viewLocationButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),
      //      organizerBgView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -(100)),

      viewLocationView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 25),
      viewLocationView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
      viewLocationView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),

      organizerBgView.topAnchor.constraint(equalTo: viewLocationView.bottomAnchor, constant: 20),
      organizerBgView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
      organizerBgView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),
      organizerBgView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -(100)),

      organizerImage.topAnchor.constraint(equalTo: organizerBgView.topAnchor, constant: 35),
      organizerImage.leftAnchor.constraint(equalTo: organizerBgView.leftAnchor, constant: 15),

      organizerNameStack.topAnchor.constraint(equalTo: organizerBgView.topAnchor, constant: 41),
      organizerNameStack.leftAnchor.constraint(equalTo: organizerImage.rightAnchor, constant: 10),

      organizerSectorLabel.topAnchor.constraint(equalTo: organizerNameStack.bottomAnchor, constant: 3),
      organizerSectorLabel.leftAnchor.constraint(equalTo: organizerImage.rightAnchor, constant: 10),

//      joinButton.topAnchor.constraint(equalTo: bottomStickyView.topAnchor, constant: 15),
//      joinButton.leftAnchor.constraint(equalTo: bottomStickyView.leftAnchor, constant: 15),
//      joinButton.rightAnchor.constraint(equalTo: bottomStickyView.rightAnchor, constant: -15),

//      favoriteImage.topAnchor.constraint(equalTo: bottomStickyView.topAnchor, constant: 15),
//      favoriteImage.rightAnchor.constraint(equalTo: bottomStickyView.rightAnchor, constant: -15)

      bottomStack.topAnchor.constraint(equalTo: bottomStickyView.topAnchor, constant: 15),
      bottomStack.leftAnchor.constraint(equalTo: bottomStickyView.leftAnchor, constant: 15),
      bottomStack.rightAnchor.constraint(equalTo: bottomStickyView.rightAnchor, constant: -15),
    ])

    posterImageView.sd_setImage(with: URL(string: data.poster)!)
    eventNameLabel.text = data.name
    dateLabel.text = Utilities.formatterDate(dateInString: data.dateStart, inFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd MMMM yyyy • HH:mm")
    locationLabel.text = eventViewModel.locationEventCustom(location: data.location.regency.name, country: data.location.country)
    freeLabel.isHidden = data.ticketPrice != "0" ? true : false
  }

  func configureBinding() {
    eventViewModel.detailEvent.bind { detail in
      self.descriptionLabel.text = detail.description
      self.organizerImage.sd_setImage(with: URL(string: detail.organizer.image))
      self.organizerNameLabel.text = detail.organizer.name
      self.organizerVerifiedImage.isHidden = !detail.organizer.isVerified
      self.organizerSectorLabel.text = detail.organizer.organizerSector
    }

    eventViewModel.joinEventStatus.bind { status in
      if status {
        let nextVC = JoinedViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
      }
    }

    eventViewModel.isLoading.bind { loading in
      if loading {
        self.showSpinner()
      } else {
        self.removeSpinner()
      }
    }
  }

  func fetchDetail() {
    eventViewModel.fetchDetailEvent(uid: self.uid)
  }

  @objc func handleBackButtonNav() {
    navigationController?.popViewController(animated: true)
  }

  @objc func handleJoinButtonTap() {
    eventViewModel.attemptJoinEvent(uid: uid)
  }

  @objc func handleViewLocationTap() {
    let vc = MapEventViewController(event: eventViewModel.detailEvent.value)
    navigationController?.pushViewController(vc, animated: true)
  }

  @objc func handleFavoriteButtonTap() {
    favoriteImage.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration.init(weight: UIImage.SymbolWeight.light)), for: .normal)
  }

}
