//
//  UpcomingEventCell.swift
//  Galla
//
//  Created by Dimas Putro on 27/06/22.
//

import UIKit

class UpcomingEventCell: UICollectionViewCell {

  static let identifier = "UpcomingEventCell"

  lazy var posterImageView: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.heightAnchor.constraint(equalToConstant: 106).isActive = true
    iv.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
    iv.image = UIImage(named: "dummy-poster")
    iv.layer.cornerRadius = 12
    iv.clipsToBounds = true

    return iv
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
    label.textColor = .systemGray3

    return label
  }()

  lazy var eventNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Lampion: From Earth to Moon 2022"
    label.font = UIFont(name: "Poppins-SemiBold", size: 14)
    label.textColor = UIColor(named: "color-black")
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0

    return label
  }()

  lazy var joinButton: UIButton = CTAButton(title: "Join")

  override init(frame: CGRect) {
    super.init(frame: frame)

    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .white
    layer.cornerRadius = 12

    let locationStack = UIStackView(arrangedSubviews: [locationIconImage, locationLabel])
    locationStack.translatesAutoresizingMaskIntoConstraints = false
    locationStack.axis = .horizontal
    locationStack.spacing = 5

    addSubview(posterImageView)
    addSubview(eventNameLabel)
    addSubview(locationStack)
    addSubview(joinButton)
    joinButton.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)

    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: 200),
      heightAnchor.constraint(equalToConstant: 262),

      posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
      posterImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
      posterImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),

      locationStack.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 13),
      locationStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
      locationStack.rightAnchor.constraint(equalTo: rightAnchor, constant: 12),

      eventNameLabel.topAnchor.constraint(equalTo: locationStack.bottomAnchor, constant: 5),
      eventNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
      eventNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 12),

      joinButton.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 20),
      joinButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
      joinButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
      joinButton.heightAnchor.constraint(equalToConstant: 33)
    ])

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
