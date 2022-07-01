//
//  CTAButton.swift
//  Galla
//
//  Created by Dimas Putro on 22/06/22.
//

import UIKit

class CTAButton: UIButton {

  var title: String

  override var buttonType: UIButton.ButtonType {
    return .system
  }

  init(title: String) {
    self.title = title

    super.init(frame: .zero)

    configureUI()
  }

  private func configureUI() {
    translatesAutoresizingMaskIntoConstraints = false

    setTitle(title, for: .normal)
    setTitleColor(UIColor.white, for: .normal)
    setTitleColor(UIColor(named: "color-primary"), for: .selected)
    heightAnchor.constraint(equalToConstant: 45).isActive = true
    backgroundColor = UIColor(named: "color-primary")
    layer.cornerRadius = 8
    titleLabel?.font = UIFont(name: "Poppins-Bold", size: 16)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


}
