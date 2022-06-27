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

  lazy var actionButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("See All", for: .normal)
    button.setTitleColor(UIColor(hexString: "8F929B"), for: .normal)
    button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 16)

    return button
  }()

//  lazy var actionButton: UILabel = {
//    let label = UILabel()
//    label.translatesAutoresizingMaskIntoConstraints = false
//    label.font = UIFont(name: "Poppins-SemiBold", size: 18)
//    label.text = "Header title"
//    label.numberOfLines = 1
//    label.textColor = UIColor(hexString: "8F929B")
//
//    return label
//  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    translatesAutoresizingMaskIntoConstraints = false
//    addSubview(titleSection)
//    addSubview(actionButton)

    let stack = UIStackView(arrangedSubviews: [titleSection, actionButton])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .horizontal
    stack.distribution = .equalSpacing

    addSubview(stack)

    NSLayoutConstraint.activate([
      stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
      stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
      stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
//
//      actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
//      actionButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
