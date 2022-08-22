//
//  SearchEventViewController.swift
//  Galla
//
//  Created by Dimas Putro on 21/08/22.
//

import UIKit

class SearchEventViewController: UIViewController {
  
  private let searchEventViewModel :SearchEventViewModel = SearchEventViewModel(eventService: Injection().provideHome())
  
  private var keyword: String
  
  lazy var navBarView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.heightAnchor.constraint(equalToConstant: 100).isActive = true
    view.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
    
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
  
  lazy var searchTextField: UITextField = {
    let tf = UITextField()
    
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.backgroundColor = UIColor.systemGray6
    tf.heightAnchor.constraint(equalToConstant: 38).isActive = true
    tf.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
    tf.layer.cornerRadius = 8
    tf.font = UIFont(name: "Poppins-Regular", size: 14)
    
    tf.placeholder = "Search event"
    tf.textColor = UIColor.systemGray
    tf.autocorrectionType = .no
    tf.setLeftPaddingPoints(15)
    tf.text = self.keyword
    tf.returnKeyType = .search
    tf.delegate = self
    
    return tf
  }()
  
  lazy var searchResultCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.register(UpcomingEventCell.self, forCellWithReuseIdentifier: UpcomingEventCell.identifier)
    cv.dataSource = self
    cv.delegate = self
    
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.heightAnchor.constraint(equalToConstant: self.view.frame.height).isActive = true
    cv.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
    cv.showsHorizontalScrollIndicator = false
    cv.backgroundColor = .clear
    
    return cv
  }()
  
  lazy var refreshControl: UIRefreshControl = UIRefreshControl()
  
  init(keyword: String) {
    self.keyword = keyword
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    configureBinding()
    
    searchEventViewModel.searchEvent(keyword: self.keyword)
  }
  
  private func configureUI() {
    view.backgroundColor = UIColor(named: "color-background")
    
    view.addSubview(navBarView)
    view.addSubview(searchResultCollectionView)
    
    let navBarStack = UIStackView(arrangedSubviews: [backButtonNavBar, searchTextField])
    navBarStack.translatesAutoresizingMaskIntoConstraints = false
    navBarStack.axis = .horizontal
    navBarStack.alignment = .center
    navBarStack.distribution = .equalSpacing
    navBarStack.spacing = 10
    
    navBarView.addSubview(navBarStack)
    
    refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
    searchResultCollectionView.alwaysBounceVertical = true
    searchResultCollectionView.refreshControl = refreshControl
    
    NSLayoutConstraint.activate([
      navBarView.topAnchor.constraint(equalTo: view.topAnchor),
      navBarView.leftAnchor.constraint(equalTo: view.leftAnchor),
      navBarView.rightAnchor.constraint(equalTo: view.rightAnchor),
      
      //      navBarStack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5),
      navBarStack.leftAnchor.constraint(equalTo: navBarView.leftAnchor, constant: 15),
      navBarStack.rightAnchor.constraint(equalTo: navBarView.rightAnchor, constant: -15),
      navBarStack.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: -15),
      
      searchResultCollectionView.topAnchor.constraint(equalTo: navBarView.bottomAnchor),
      searchResultCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
      searchResultCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
    ])
  }
  
  func configureBinding() {
    searchEventViewModel.isLoading.bind { isLoading in
      if isLoading {
        self.showSpinner(style: .medium, color: .black, backgroundColor: .clear)
      } else {
        self.removeSpinner()
      }
    }
    
    searchEventViewModel.resultEvents.bind { result in
      self.searchResultCollectionView.reloadData()
      self.refreshControl.endRefreshing()
    }
  }
  
  @objc func handleBackButtonNav() {
    navigationController?.popToRootViewController(animated: true)
  }
  
  @objc func didPullToRefresh(_ sender: Any) {
    searchEventViewModel.searchEvent(refresh: true, keyword: keyword)
  }
}

extension SearchEventViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    
    searchEventViewModel.searchEvent(keyword: textField.text ?? "")
    
    return true
  }
}

extension SearchEventViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 15, left: 15, bottom: 5, right: 15)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 200 - 25, height: 262)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let data = searchEventViewModel.resultEvents.value[indexPath.row]
    
    let vc = DetailEventViewController(uid: data.uid, data: data)
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension SearchEventViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return searchEventViewModel.resultEvents.value.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let data = searchEventViewModel.resultEvents.value[indexPath.row]
    
    let cell = searchResultCollectionView.dequeueReusableCell(withReuseIdentifier: UpcomingEventCell.identifier, for: indexPath) as! UpcomingEventCell
    cell.eventNameLabel.text = data.name
    cell.locationLabel.text = String().locationEventCustom(location: data.location.regency.name, country: data.location.country)
    cell.posterImageView.sd_setImage(with: URL(string: data.poster)!, placeholderImage: UIImage(named: "dummy-poster"))
    cell.dateLabel.text = Utilities.formatterDate(dateInString: data.dateStart, inFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd")
    cell.monthLabel.text = Utilities.formatterDate(dateInString: data.dateStart, inFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "MMM")
    
    return cell
  }
  
  
}

