//
//  HomeViewController.swift
//  Galla
//
//  Created by Dimas Putro on 22/06/22.
//

import UIKit
import SDWebImage

protocol HomeViewControllerProtocol: AnyObject {
  func changeLocation(location: LocationResult)
}

class HomeViewController: UIViewController {

  let eventViewModel: EventViewModel = EventViewModel(eventService: Injection().provideHome(), locationService: Injection().provideSearch())

  lazy var scrollView: UIScrollView = {
    let sv = UIScrollView(frame: .zero)
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.bounces = true
    sv.backgroundColor = UIColor(named: "color-background")

    return sv
  }()

  lazy var containerView: UIView = {
    let sv = UIView()
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.backgroundColor = UIColor(named: "color-background")

    return sv
  }()

  lazy var nearEventLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Find event near"
    label.font = UIFont(name: "Poppins-Regular", size: 14)
    label.textColor = UIColor.systemGray2

    return label
  }()

//  lazy var myLocationHeader: UIView = {
//    let view = UIView()
//    view.translatesAutoresizingMaskIntoConstraints = false
//
//    let label = UILabel()
//    label.translatesAutoresizingMaskIntoConstraints = false
//    label.text = "Bandung, ID"
//    label.font = UIFont(name: "Poppins-SemiBold", size: 20)
//    label.textColor = UIColor(named: "color-black")
//
//    let image = UIImageView()
//    let config = UIImage.SymbolWeight.bold
//    image.translatesAutoresizingMaskIntoConstraints = false
//    image.image = UIImage(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration.init(weight: config))
//    image.tintColor = UIColor(named: "color-black")
//
//    view.addSubview(label)
//    view.addSubview(image)
//
//    image.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0).isActive = true
//    image.leftAnchor.constraint(equalTo: label.rightAnchor, constant: 5).isActive = true
//
//    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLocationHeaderTap)))
//    view.isUserInteractionEnabled = true
//
//    return view
//  }()

  var locationLabel: UILabel = {
    let label = UILabel()

    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "-"
    label.font = UIFont(name: "Poppins-SemiBold", size: 20)
    label.textColor = UIColor(named: "color-black")

    return label
  }()


  lazy var myLocationHeader: UIButton = {
    let btn = UIButton(type: .system)
    btn.translatesAutoresizingMaskIntoConstraints = false

    let label = locationLabel
//    label.translatesAutoresizingMaskIntoConstraints = false
//    label.text = "Bandung, ID"
//    label.font = UIFont(name: "Poppins-SemiBold", size: 20)
//    label.textColor = UIColor(named: "color-black")

    let image = UIImageView()
    let config = UIImage.SymbolWeight.bold
    image.translatesAutoresizingMaskIntoConstraints = false
    image.image = UIImage(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration.init(weight: config))
    image.tintColor = UIColor(named: "color-black")

    btn.addSubview(label)
    btn.addSubview(image)

    image.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0).isActive = true
    image.leftAnchor.constraint(equalTo: label.rightAnchor, constant: 5).isActive = true

    btn.widthAnchor.constraint(equalToConstant: 150).isActive = true

    btn.addTarget(self, action: #selector(handleLocationHeaderTap), for: .touchUpInside)

    return btn
  }()

  lazy var profileImage: UIImageView = {
    let img = UIImageView()
    img.translatesAutoresizingMaskIntoConstraints = false
    img.widthAnchor.constraint(equalToConstant: 48).isActive = true
    img.heightAnchor.constraint(equalToConstant: 48).isActive = true
    img.image = UIImage(named: "dummy-profile")
    img.backgroundColor = UIColor.systemGray3
    img.layer.cornerRadius = 48 / 2
    img.clipsToBounds = true

    return img
  }()

  lazy var placeholderSearchLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Search all events..."
    label.font = UIFont(name: "Poppins-Regular", size: 14)
    label.textColor = .systemGray2

    return label
  }()

  lazy var placeholderSearchImage: UIImageView = {
    let img = UIImageView()
    img.translatesAutoresizingMaskIntoConstraints = false
    img.image = UIImage(named: "icon-search")
    img.widthAnchor.constraint(equalToConstant: 18).isActive = true
    img.heightAnchor.constraint(equalToConstant: 18).isActive = true

    return img
  }()

  lazy var searchTextField: UITextField = {
    let tf = UITextField()

    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.backgroundColor = UIColor.white
    tf.heightAnchor.constraint(equalToConstant: 54).isActive = true
    tf.layer.cornerRadius = 12
    tf.font = UIFont(name: "Poppins-Regular", size: 14)

    return tf
  }()

  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewCompositionalLayout {
      sectionIndex, _  in
      return HomeViewController.createSectionLayout(section: sectionIndex)
    }
    layout.configuration.scrollDirection = .horizontal

    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.register(UpcomingEventCell.self, forCellWithReuseIdentifier: UpcomingEventCell.identifier)
    cv.register(PopularEventCell.self, forCellWithReuseIdentifier: PopularEventCell.identifier)
    cv.register(TitleHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier)
    cv.delegate = self
    cv.dataSource = self
    cv.backgroundColor = .clear
    cv.alwaysBounceVertical = false
    cv.scrollsToTop = false
    // untuk disable scroll vertical
    cv.isScrollEnabled = false

    return cv
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    configureUI()
    configureBinding()

    eventViewModel.fetchPopularEvent(location: "", isFinished: false)
    eventViewModel.fetchUpcomingEvent(location: "")
    eventViewModel.getSelectedLocation()
  }

  private func configureUI() {
    title = "Home"
    navigationController?.navigationBar.isHidden = true

    view.addSubview(scrollView)
    scrollView.addSubview(containerView)
    scrollView.addSubview(collectionView)

    let myLoationStack = UIStackView(arrangedSubviews: [nearEventLabel, myLocationHeader])
    myLoationStack.translatesAutoresizingMaskIntoConstraints = false
    myLoationStack.axis = .vertical
    myLoationStack.spacing = 3

    let searchPlaceholderStack = UIStackView(arrangedSubviews: [placeholderSearchImage, placeholderSearchLabel])
    searchPlaceholderStack.translatesAutoresizingMaskIntoConstraints = false
    searchPlaceholderStack.axis = .horizontal
    searchPlaceholderStack.spacing = 15

    containerView.addSubview(myLoationStack)
    containerView.addSubview(profileImage)
    containerView.addSubview(searchTextField)
    searchTextField.addSubview(searchPlaceholderStack)
    searchTextField.setLeftPaddingPoints(45)

    NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextField.textDidChangeNotification, object: nil)

    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
      scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
      scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),

      containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
      containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
      containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0),
      containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0),
      containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
      containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

      myLoationStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
      myLoationStack.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),

      profileImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
      profileImage.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),

      searchTextField.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
      searchTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
      searchTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),

      searchPlaceholderStack.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor, constant: 0),
      searchPlaceholderStack.leftAnchor.constraint(equalTo: searchTextField.leftAnchor, constant: 13),

      collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 5),
      collectionView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0),
      collectionView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0),
      collectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
    ])
  }

  private func configureBinding() {
    eventViewModel.upcomingEvents.bind { _ in
      self.collectionView.reloadData()
    }

    eventViewModel.selectedLocation.bind { location in
      self.locationLabel.text = "\(location.name), ID"
    }
  }

  @objc func handleTextInputChange() {
    placeholderSearchLabel.isHidden = !searchTextField.text!.isEmpty
  }

  @objc func handleLocationHeaderTap() {
    let vc = SearchLocationViewController()
    vc.delegate = self
    navigationController?.present(vc, animated: true)
  }
}

extension HomeViewController: HomeViewControllerProtocol {
  func changeLocation(location: LocationResult) {
    locationLabel.text = location.name + ", ID"
  }
}

extension HomeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch indexPath.section {
    case 0:
      let data = eventViewModel.upcomingEvents.value[indexPath.row]

      let vc = DetailEventViewController(uid: data.uid, data: data)
      vc.hidesBottomBarWhenPushed = true
      navigationController?.pushViewController(vc, animated: true)
    case 1:
      let data = eventViewModel.popularEvents.value[indexPath.row]

      let vc = DetailEventViewController(uid: data.uid, data: data)
      vc.hidesBottomBarWhenPushed = true
      navigationController?.pushViewController(vc, animated: true)
    default:
      return
    }
  }
}

extension HomeViewController: UICollectionViewDataSource {

  // jumlah section
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }

  // jumlah item per section
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0:
      return eventViewModel.upcomingEvents.value.count
    case 1:
      return eventViewModel.popularEvents.value.count
    default:
      return 0
    }
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch indexPath.section {
    case 0:
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier, for: indexPath) as! TitleHeaderCollectionReusableView
      header.titleSection.text = "Upcoming Events"
      header.actionButton.isHidden = true

      return header
    case 1:
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier, for: indexPath) as! TitleHeaderCollectionReusableView
      header.titleSection.text = "Popular Now"

      return header
    default:
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier, for: indexPath) as! TitleHeaderCollectionReusableView
      header.titleSection.text = "None"

      return header
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    case 0:
      let data = eventViewModel.upcomingEvents.value[indexPath.row]

      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingEventCell.identifier, for: indexPath) as! UpcomingEventCell
      cell.eventNameLabel.text = data.name
      cell.locationLabel.text = eventViewModel.locationEventCustom(location: data.location.regency.name, country: data.location.country)
      cell.posterImageView.sd_setImage(with: URL(string: data.poster)!, placeholderImage: UIImage(named: "dummy-poster"))
      cell.dateLabel.text = Utilities.formatterDate(dateInString: data.dateStart, inFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd")
      cell.monthLabel.text = Utilities.formatterDate(dateInString: data.dateStart, inFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "MMM")

      return cell
    case 1:
      let data = eventViewModel.popularEvents.value[indexPath.row]

      let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  PopularEventCell.identifier, for: indexPath) as! PopularEventCell
      cell.eventNameLabel.text = data.name
      cell.posterImageView.sd_setImage(with: URL(string: data.poster)!, placeholderImage: UIImage(named: "dummy-poster"))
      cell.freeLabel.isHidden = data.ticketPrice != "0" ? true : false
      cell.dateLabel.text = Utilities.formatterDate(dateInString: data.dateStart, inFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd MMMM yyyy • HH:mm")

      return cell
    default:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingEventCell.identifier, for: indexPath)

      return cell
    }
  }
}

extension HomeViewController {
  static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
    let supplementaryHeader = [
      NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    ]

    switch section {
    case 0:
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))

      let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
      layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)

      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(262))

      let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      layoutSection.orthogonalScrollingBehavior = .continuous
      layoutSection.boundarySupplementaryItems = supplementaryHeader

      return layoutSection
    case 1:
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))

      let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
      layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)

      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(290), heightDimension: .absolute(228))

      let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      layoutSection.orthogonalScrollingBehavior = .continuous
      layoutSection.boundarySupplementaryItems = supplementaryHeader

      return layoutSection
    default:
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))

      let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
      layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(262))

      let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

      let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      layoutSection.orthogonalScrollingBehavior = .continuous

      return layoutSection
    }
  }
}
