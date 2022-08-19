//
//  FavoriteViewController.swift
//  Galla
//
//  Created by Dimas Putro on 19/08/22.
//

import UIKit

class FavoriteViewController: UIViewController {

  private let favoriteViewModel: FavoriteViewModel = FavoriteViewModel(eventService: Injection().provideHome())
  
  lazy var navBarView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.heightAnchor.constraint(equalToConstant: 91).isActive = true
    view.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true

    return view
  }()

  lazy var titleNavBar: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Favorites"
    label.textColor = UIColor(named: "color-black")
    label.font = UIFont(name: "Poppins-SemiBold", size: 14)

    return label
  }()

  lazy var leftButtonNavBar: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "chevron.left")?.withTintColor(UIColor(named: "color-black")!, renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration.init(weight: UIImage.SymbolWeight.semibold)), for: .normal)
    button.heightAnchor.constraint(equalToConstant: 22).isActive = true
    button.widthAnchor.constraint(equalToConstant: 22).isActive = true

//    button.addTarget(self, action: #selector(handleBackButtonNav), for: .touchUpInside)

//    button.isHidden = true

    return button
  }()

  lazy var notifButtonNavBar: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "bell")?.withTintColor(UIColor(named: "color-black")!, renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration.init(weight: UIImage.SymbolWeight.semibold)), for: .normal)
    button.heightAnchor.constraint(equalToConstant: 22).isActive = true
    button.widthAnchor.constraint(equalToConstant: 22).isActive = true

    return button
  }()

  lazy var favoriteCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: self.view.frame.width, height: 240)
    layout.scrollDirection = .vertical

    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.register(PopularEventCell.self, forCellWithReuseIdentifier: PopularEventCell.identifier)
    cv.dataSource = self
    cv.delegate = self

    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.heightAnchor.constraint(equalToConstant: self.view.frame.height).isActive = true
    cv.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
    cv.showsHorizontalScrollIndicator = false
    cv.backgroundColor = .clear

    return cv
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    configureBinding()

    favoriteViewModel.fetchFavorite()
  }

  private func configureUI() {
    view.backgroundColor = UIColor(named: "color-background")

    view.addSubview(navBarView)
    view.addSubview(favoriteCollectionView)

    let navBarStack = UIStackView(arrangedSubviews: [leftButtonNavBar, titleNavBar, notifButtonNavBar])
    navBarStack.translatesAutoresizingMaskIntoConstraints = false
    navBarStack.axis = .horizontal
    navBarStack.alignment = .center
    navBarStack.distribution = .equalSpacing

//    navBarView.addSubview(navBarStack)

    NSLayoutConstraint.activate([
      navBarView.topAnchor.constraint(equalTo: view.topAnchor),
      navBarView.leftAnchor.constraint(equalTo: view.leftAnchor),
      navBarView.rightAnchor.constraint(equalTo: view.rightAnchor),

      favoriteCollectionView.topAnchor.constraint(equalTo: navBarView.bottomAnchor),
      favoriteCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
      favoriteCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
      favoriteCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }

  private func configureBinding() {
    favoriteViewModel.favorites.bind { events in
      self.favoriteCollectionView.reloadData()
    }
  }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 15, left: 15, bottom: 5, right: 15)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.frame.width - 30, height: 240)
  }
}

extension FavoriteViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return favoriteViewModel.favorites.value.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let data = favoriteViewModel.favorites.value[indexPath.row]

    let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: PopularEventCell.identifier, for: indexPath) as! PopularEventCell
    cell.eventNameLabel.text = data.name
    cell.posterImageView.sd_setImage(with: URL(string: data.poster)!, placeholderImage: UIImage(named: "dummy-poster"))
    cell.freeLabel.isHidden = data.ticketPrice != "0" ? true : false
    cell.dateLabel.text = Utilities.formatterDate(dateInString: data.dateStart, inFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd MMMM yyyy • HH:mm")

    return cell
  }


}
