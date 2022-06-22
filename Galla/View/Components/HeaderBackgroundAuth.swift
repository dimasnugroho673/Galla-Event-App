//
//  HeaderBackgroundAuth.swift
//  Galla
//
//  Created by Dimas Putro on 22/06/22.
//

import UIKit

class HeaderBackgroundAuth: UIView {

  var title: String
  var subtitle: String
  var imageBackground: UIImage
  var width: CGFloat

  lazy var imageView: UIImageView = {
    let img = UIImageView()
    img.translatesAutoresizingMaskIntoConstraints = false
    img.contentMode = .scaleAspectFill
    img.image = self.imageBackground
    img.heightAnchor.constraint(equalToConstant: 323).isActive = true
    img.widthAnchor.constraint(equalToConstant: width).isActive = true
    img.clipsToBounds = true

    return img
  }()

  lazy var darkenLayerView: UIView = {
    let img = UIView()
    img.translatesAutoresizingMaskIntoConstraints = false
    img.backgroundColor = UIColor(hexString: "2C1F19").withAlphaComponent(0.86)
    img.heightAnchor.constraint(equalToConstant: 323).isActive = true
    img.widthAnchor.constraint(equalToConstant: width).isActive = true

    return img
  }()

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = self.title
    label.font = UIFont(name: "Poppins-Bold", size: 44)
    label.textColor = UIColor.white

    return label
  }()

  lazy var subtitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = self.subtitle
    label.font = UIFont(name: "Poppins-Regular", size: 14)
    label.textColor = UIColor.white

    return label
  }()

  init(title: String, subtitle: String, imageBackground: UIImage, width: CGFloat) {
    self.title = title
    self.subtitle = subtitle
    self.imageBackground = imageBackground
    self.width = width

    super.init(frame: .zero)

    configureUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configureUI() {
    translatesAutoresizingMaskIntoConstraints = false
    addSubview(imageView)
    addSubview(darkenLayerView)
    darkenLayerView.addSubview(titleLabel)
    darkenLayerView.addSubview(subtitleLabel)

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
      imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),

      darkenLayerView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      darkenLayerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
      darkenLayerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),

      titleLabel.topAnchor.constraint(equalTo: darkenLayerView.topAnchor, constant: 166),
      titleLabel.leftAnchor.constraint(equalTo: darkenLayerView.leftAnchor, constant: 23),

      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
      subtitleLabel.leftAnchor.constraint(equalTo: darkenLayerView.leftAnchor, constant: 23),
    ])
  }
}
