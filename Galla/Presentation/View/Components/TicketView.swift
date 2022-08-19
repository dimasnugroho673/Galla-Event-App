//
//  TicketView.swift
//  Galla
//
//  Created by Dimas Putro on 15/08/22.
//

import UIKit

class TicketView: UIView {

  var width: CGFloat

  private lazy var header: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false

    view.clipsToBounds = true
    view.layer.cornerRadius = 18
    view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    view.backgroundColor = UIColor(hexString: "1A2C50")

    return view
  }()

  private lazy var body: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false

    view.backgroundColor = UIColor(hexString: "EAC16E")

    return view
  }()

  private lazy var footer: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false

    view.clipsToBounds = true
    view.layer.cornerRadius = 18
    view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    view.backgroundColor = UIColor(hexString: "EAC16E")

    return view
  }()

  init(width: CGFloat) {
    self.width = width

    super.init(frame: .zero)

    configureUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureUI() {
    translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(header)
    addSubview(body)
    addSubview(footer)

//    heightAnchor.constraint(equalToConstant: 500).isActive = true
    widthAnchor.constraint(equalToConstant: width).isActive = true

    header.heightAnchor.constraint(equalToConstant: 160).isActive = true
    header.widthAnchor.constraint(equalToConstant: width).isActive = true

    body.heightAnchor.constraint(equalToConstant: 185).isActive = true
    body.widthAnchor.constraint(equalToConstant: width).isActive = true

    footer.heightAnchor.constraint(equalToConstant: 160).isActive = true
    footer.widthAnchor.constraint(equalToConstant: width).isActive = true

    let lineStack = UIStackView(arrangedSubviews: [])
    lineStack.translatesAutoresizingMaskIntoConstraints = false
    lineStack.axis = .horizontal
    lineStack.distribution = .equalCentering
    lineStack.spacing = 5

    addSubview(lineStack)

    for _ in 1...20 {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.heightAnchor.constraint(equalToConstant: 2).isActive = true
      view.widthAnchor.constraint(equalToConstant: 10).isActive = true
      view.backgroundColor = UIColor(named: "color-background")

      lineStack.addArrangedSubview(view)
    }

    let bodyClipStack = UIStackView(arrangedSubviews: [])
    bodyClipStack.translatesAutoresizingMaskIntoConstraints = false
    bodyClipStack.axis = .horizontal
    bodyClipStack.distribution = .equalCentering
    bodyClipStack.spacing = 10

    addSubview(bodyClipStack)

    for _ in 1...2 {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 40 / 2
        view.backgroundColor = UIColor(named: "color-background")

        bodyClipStack.addArrangedSubview(view)
    }


//    let limit = Int(width / 40)
//
//    for _ in 1...limit {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.heightAnchor.constraint(equalToConstant: 23).isActive = true
//        view.widthAnchor.constraint(equalToConstant: 23).isActive = true
//        view.clipsToBounds = true
//        view.layer.cornerRadius = 23 / 2
//        view.backgroundColor = UIColor(named: "color-background")
//
//        bodyClipStack.addArrangedSubview(view)
//    }

    NSLayoutConstraint.activate([
      header.topAnchor.constraint(equalTo: topAnchor),
      header.rightAnchor.constraint(equalTo: rightAnchor),
      header.leftAnchor.constraint(equalTo: leftAnchor),

      body.topAnchor.constraint(equalTo: header.bottomAnchor),
      body.rightAnchor.constraint(equalTo: rightAnchor),
      body.leftAnchor.constraint(equalTo: leftAnchor),

      bodyClipStack.widthAnchor.constraint(equalToConstant: width),
      bodyClipStack.topAnchor.constraint(equalTo: body.bottomAnchor, constant: -20),
      bodyClipStack.leftAnchor.constraint(equalTo: leftAnchor, constant: -15),
      bodyClipStack.rightAnchor.constraint(equalTo: rightAnchor, constant: 15),

      footer.topAnchor.constraint(equalTo: body.bottomAnchor),
      footer.rightAnchor.constraint(equalTo: rightAnchor),
      footer.leftAnchor.constraint(equalTo: leftAnchor),
      footer.bottomAnchor.constraint(equalTo: bottomAnchor),

      lineStack.widthAnchor.constraint(equalToConstant: width - 30),
      lineStack.topAnchor.constraint(equalTo: footer.topAnchor),
      lineStack.rightAnchor.constraint(equalTo: bodyClipStack.rightAnchor),
      lineStack.leftAnchor.constraint(equalTo: bodyClipStack.leftAnchor),
    ])
  }
}
