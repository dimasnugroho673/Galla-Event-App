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



  override init(frame: CGRect) {
    super.init(frame: frame)

    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .white
    layer.cornerRadius = 12

    addSubview(posterImageView)

    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: 200),
      heightAnchor.constraint(equalToConstant: 262),

      posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      posterImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
      posterImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
    ])

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
