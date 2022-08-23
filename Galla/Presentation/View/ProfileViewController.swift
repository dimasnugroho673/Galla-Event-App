//
//  ProfileViewController.swift
//  Galla
//
//  Created by Dimas Putro on 22/08/22.
//

import UIKit

class ProfileViewController: UIViewController {

  private let profileViewModel: ProfileViewModel = ProfileViewModel(userService: Injection().provideAuth(), locationService: Injection().provideSearch())

  private lazy var scrollView: UIScrollView = {
    let sv = UIScrollView(frame: .zero)
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.bounces = true
    sv.backgroundColor = UIColor(named: "color-background")
    sv.autoresizingMask = .flexibleHeight

    return sv
  }()

  private lazy var containerView: UIView = {
    let sv = UIView()
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.backgroundColor = UIColor(named: "color-background")
    sv.autoresizingMask = .flexibleHeight

    return sv
  }()

  private lazy var coverBackgroundImage: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor(named: "color-primary")
    view.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
    view.heightAnchor.constraint(equalToConstant: 150).isActive = true

    return view
  }()

  lazy var notifButtonNavBar: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "bell")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration.init(weight: UIImage.SymbolWeight.semibold)), for: .normal)
    button.heightAnchor.constraint(equalToConstant: 22).isActive = true
    button.widthAnchor.constraint(equalToConstant: 22).isActive = true

    return button
  }()

  private lazy var whiteBackgroundView: UIView = {
    let sv = UIView()
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.backgroundColor = .white
    sv.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
    sv.heightAnchor.constraint(equalToConstant: 181).isActive = true

    return sv
  }()

  private lazy var profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = .lightGray
    iv.layer.borderColor = UIColor.white.cgColor
    iv.layer.borderWidth = 4
    iv.image = UIImage(named: "dummy-profile")
    iv.widthAnchor.constraint(equalToConstant: 78).isActive = true
    iv.heightAnchor.constraint(equalToConstant: 78).isActive = true
    iv.layer.cornerRadius = 78 / 2

    return iv
  }()

  private lazy var editProfileButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Edit profile", for: .normal)
    button.layer.borderColor = UIColor(named: "color-primary")?.cgColor
    button.layer.borderWidth = 1.25
    button.setTitleColor(UIColor(named: "color-primary"), for: .normal)
    button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 14)
    button.backgroundColor = .clear
    button.widthAnchor.constraint(equalToConstant: 103).isActive = true
    button.heightAnchor.constraint(equalToConstant: 31).isActive = true
    button.clipsToBounds = true
    button.layer.cornerRadius = 31 / 2
    //    button.addTarget(self, action: #selector(handleEditProfile), for: .touchUpInside)

    return button
  }()

  private lazy var fullnameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: "Poppins-Bold", size: 18)
    label.text = ""
    label.textColor = .black

    return label
  }()

  private lazy var accountTypeButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Personal Account", for: .normal)
    button.setTitleColor(UIColor.black, for: .normal)
    button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 12)
    button.backgroundColor = UIColor(hexString: "D9D9D9")
    button.widthAnchor.constraint(equalToConstant: 130).isActive = true
    button.heightAnchor.constraint(equalToConstant: 19).isActive = true
    button.clipsToBounds = true
    button.layer.cornerRadius = 19 / 2

    return button
  }()

  private lazy var locationLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = ""
    label.font = UIFont(name: "Poppins-Medium", size: 12)
    label.textColor = UIColor(hexString: "7D7D7D")

    return label
  }()

  private lazy var joinedAccountLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = ""
    label.font = UIFont(name: "Poppins-Medium", size: 12)
    label.textColor = UIColor(hexString: "7D7D7D")

    return label
  }()

  private lazy var joinedCanceledEventLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "[count.joinedEvent] Event joined | [count.canceledEvent] Event canceled"
    label.font = UIFont(name: "Poppins-Medium", size: 12)
    label.textColor = UIColor(hexString: "7D7D7D")
    label.numberOfLines = 0
    label.lineBreakMode = .byCharWrapping

    return label
  }()

  lazy var refreshControl: UIRefreshControl = UIRefreshControl()

  override func viewDidLoad() {
    super.viewDidLoad()

    configureUI()
    configureBinding()

    profileViewModel.fetchUserData()
  }

  private func configureUI() {
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.barStyle = .black
    view.backgroundColor = UIColor(named: "color-background")

    view.addSubview(scrollView)
    scrollView.addSubview(containerView)
    scrollView.contentInsetAdjustmentBehavior = .never
    containerView.addSubview(coverBackgroundImage)
    coverBackgroundImage.addSubview(notifButtonNavBar)
    containerView.addSubview(whiteBackgroundView)
    whiteBackgroundView.addSubview(profileImageView)
    whiteBackgroundView.addSubview(editProfileButton)
    whiteBackgroundView.addSubview(fullnameLabel)
    whiteBackgroundView.addSubview(accountTypeButton)

//    refreshControl.translatesAutoresizingMaskIntoConstraints = false
    refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
    scrollView.refreshControl = refreshControl
//    scrollView.refreshControl?.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true

    let locationAndJoinedStack = UIStackView(arrangedSubviews: [locationLabel, joinedAccountLabel])
    locationAndJoinedStack.translatesAutoresizingMaskIntoConstraints = false
    locationAndJoinedStack.axis = .horizontal
    locationAndJoinedStack.distribution = .fillProportionally
    locationAndJoinedStack.spacing = 5

    whiteBackgroundView.addSubview(locationAndJoinedStack)
    whiteBackgroundView.addSubview(joinedCanceledEventLabel)

    joinedCanceledEventLabel.textColor = .clear

    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
      scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
      scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),

      containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
      containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
      containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0),
      containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0),
      containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

      coverBackgroundImage.topAnchor.constraint(equalTo: containerView.topAnchor),
      coverBackgroundImage.leftAnchor.constraint(equalTo: containerView.leftAnchor),
      coverBackgroundImage.rightAnchor.constraint(equalTo: containerView.rightAnchor),

      notifButtonNavBar.rightAnchor.constraint(equalTo: coverBackgroundImage.rightAnchor, constant: -15),
      notifButtonNavBar.topAnchor.constraint(equalTo: coverBackgroundImage.topAnchor, constant: 55),

      whiteBackgroundView.topAnchor.constraint(equalTo: coverBackgroundImage.bottomAnchor),
      whiteBackgroundView.leftAnchor.constraint(equalTo: coverBackgroundImage.leftAnchor),
      whiteBackgroundView.rightAnchor.constraint(equalTo: coverBackgroundImage.rightAnchor),
      whiteBackgroundView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -(100)),

      profileImageView.topAnchor.constraint(equalTo: whiteBackgroundView.topAnchor, constant: -30),
      profileImageView.leftAnchor.constraint(equalTo: whiteBackgroundView.leftAnchor, constant: 15),

      editProfileButton.topAnchor.constraint(equalTo: whiteBackgroundView.topAnchor, constant: 10),
      editProfileButton.rightAnchor.constraint(equalTo: whiteBackgroundView.rightAnchor, constant: -15),

      fullnameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
      fullnameLabel.leftAnchor.constraint(equalTo: whiteBackgroundView.leftAnchor, constant: 15),

      accountTypeButton.topAnchor.constraint(equalTo: fullnameLabel.bottomAnchor, constant: 5),
      accountTypeButton.leftAnchor.constraint(equalTo: whiteBackgroundView.leftAnchor, constant: 15),

      locationAndJoinedStack.topAnchor.constraint(equalTo: accountTypeButton.bottomAnchor, constant: 10),
      locationAndJoinedStack.leftAnchor.constraint(equalTo: whiteBackgroundView.leftAnchor, constant: 15),
      locationAndJoinedStack.rightAnchor.constraint(equalTo: whiteBackgroundView.rightAnchor, constant: -15),

      joinedCanceledEventLabel.topAnchor.constraint(equalTo: locationAndJoinedStack.bottomAnchor, constant: 10),
      joinedCanceledEventLabel.leftAnchor.constraint(equalTo: whiteBackgroundView.leftAnchor, constant: 15),
      joinedCanceledEventLabel.rightAnchor.constraint(equalTo: whiteBackgroundView.rightAnchor, constant: -15),
    ])
  }

  private func configureBinding() {
    profileViewModel.user.bind({ user in
      self.fullnameLabel.text = user.name

      let location = NSTextAttachment().setLeftImage(color: UIColor(hexString: "7D7D7D"), text: "\(self.profileViewModel.selectedLocation.value.name)", imageString: "icon-location-line-gray", imageType: .named)
      let joined = NSTextAttachment().setLeftImage(color: UIColor(hexString: "7D7D7D"), text: "Joined \(user.joined)", imageString: "icon-calendar-line", imageType: .named, offsetY: -4.0)

      self.locationLabel.attributedText = location
      self.joinedAccountLabel.attributedText = joined

      if user.uid != "" {
        self.joinedCanceledEventLabel.textColor = UIColor(hexString: "7D7D7D")

        self.joinedCanceledEventLabel.colorAttributeString(text: self.joinedCanceledEventLabel.attributedText!, coloredText: "[count.joinedEvent]", changeTextTo: "\(user.eventJoined)", color: .black, textStyle:  UIFont(name: "Poppins-ExtraBold", size: 12)!)
        self.joinedCanceledEventLabel.colorAttributeString(text: self.joinedCanceledEventLabel.attributedText!, coloredText: "[count.canceledEvent]", changeTextTo: "\(user.eventCanceled)", color: .black, textStyle:  UIFont(name: "Poppins-ExtraBold", size: 12)!)
      }

      self.refreshControl.endRefreshing()
    })

  }

  @objc func didPullToRefresh(_ sender: Any) {
    profileViewModel.fetchUserData(refresh: true)
  }
}
