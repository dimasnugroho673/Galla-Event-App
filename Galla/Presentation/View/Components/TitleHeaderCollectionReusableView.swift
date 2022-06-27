//
//  TitleHeaderCollectionReusableView.swift
//  Galla
//
//  Created by Dimas Putro on 27/06/22.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
  static let identifier = "TitleHeaderCollectionReusableView"

  lazy var titleSection: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: "Poppins-SemiBold", size: 18)
    label.text = "Header title"
    label.numberOfLines = 1
    label.textColor = UIColor(named: "color-black")

    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    translatesAutoresizingMaskIntoConstraints = false
    addSubview(titleSection)

    NSLayoutConstraint.activate([

      titleSection.centerYAnchor.constraint(equalTo: centerYAnchor),
      titleSection.leftAnchor.constraint(equalTo: leftAnchor, constant: 15)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
