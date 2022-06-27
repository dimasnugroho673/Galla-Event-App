//
//  PopularEventCell.swift
//  Galla
//
//  Created by Dimas Putro on 27/06/22.
//

import UIKit

class PopularEventCell: UICollectionViewCell {

  static let identifier = "PopularEventCell"

  lazy var posterImageView: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.heightAnchor.constraint(equalToConstant: 150).isActive = true
    iv.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
    iv.image = UIImage(named: "dummy-poster")
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
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0

    return label
  }()

  lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "9 Agustus 2022 • 17:00"
    label.font = UIFont(name: "Poppins-Regular", size: 12)
    label.textColor = .systemGray3

    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .white
    layer.cornerRadius = 12
    layer.shadowColor = UIColor(hexString: "F4F4F4").cgColor
    layer.shadowOpacity = 1
    layer.shadowRadius = 30
    layer.shadowOffset = CGSize(width: 10, height: 10)

    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale

    addSubview(posterImageView)
    posterImageView.addSubview(freeLabel)
    addSubview(eventNameLabel)
    addSubview(dateLabel)

    NSLayoutConstraint.activate([
      posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      posterImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
      posterImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),

      freeLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -10),
      freeLabel.rightAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: -10),

      eventNameLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
      eventNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
      eventNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),

      dateLabel.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 2),
      dateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
      eventNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
    ])

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
