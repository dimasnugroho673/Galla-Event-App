//
//  TicketTableViewCell.swift
//  Galla
//
//  Created by Dimas Putro on 15/08/22.
//

import UIKit

class TickerTableViewCell: UITableViewCell {

  static let identifier: String = "TicketCell"

  var width: CGFloat?
  var ticket: Ticket?

  lazy var ticketView: TicketView = TicketView(width: self.width ?? 0.0, ticket: self.ticket!)

  lazy var label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 14)
    label.numberOfLines = 0
    label.text = "Some test caption"
    label.textColor = .black
    label.backgroundColor = .blue

    return label
  }()

  private lazy var header: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false

    view.heightAnchor.constraint(equalToConstant: 180).isActive = true

    view.layer.maskedCorners = .layerMaxXMaxYCorner
    view.layer.maskedCorners = .layerMaxXMinYCorner
    view.backgroundColor = UIColor(hexString: "1A2C50")

    return view
  }()

  private lazy var body: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false

    view.heightAnchor.constraint(equalToConstant: 180).isActive = true

    view.backgroundColor = UIColor(hexString: "FFECBA")

    return view
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

//    translatesAutoresizingMaskIntoConstraints = false

//    addSubview(header)
//    addSubview(body)


//    let stack = UIStackView(arrangedSubviews: [header, body])
//    stack.axis = .vertical
//    stack.translatesAutoresizingMaskIntoConstraints = false

//    addSubview(stack)

//    backgroundColor = .blue





//    heightAnchor.constraint(equalToConstant: 500).isActive = true
    //    widthAnchor.constraint(equalToConstant: self.contentView.frame.size.width).isActive = true
//    print("DEBUG: WIDTH: \(self.width)")
  }

  init(width: CGFloat, ticket: Ticket) {
    super.init(style: .default, reuseIdentifier: "TicketCell")

    self.width = width
    self.ticket = ticket
  }

  override func layoutSubviews() {
    ticketView.width = self.width ?? 0.0

    addSubview(ticketView)
//    NSLayoutConstraint.activate([
//      ticketView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
//      ticketView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
//    ])
//    addSubview(label)
//    heightAnchor.constraint(equalToConstant: 316).isActive = true
//    widthAnchor.constraint(equalToConstant: self.contentView.frame.width).isActive = true
//
//    header.heightAnchor.constraint(equalToConstant: 158).isActive = true
//    header.widthAnchor.constraint(equalToConstant: self.contentView.frame.width).isActive = true
//
//    body.heightAnchor.constraint(equalToConstant: 158).isActive = true
//    body.widthAnchor.constraint(equalToConstant: self.contentView.frame.width).isActive = true
//
    NSLayoutConstraint.activate([
            ticketView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            ticketView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            ticketView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            ticketView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),

//      label.centerYAnchor.constraint(equalTo: centerYAnchor),
//      header.topAnchor.constraint(equalTo: topAnchor, constant: 15),
//      header.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
//      header.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
//
//      body.topAnchor.constraint(equalTo: header.bottomAnchor),
//      body.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
//      body.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
//      body.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
    ])
  }

  override class func awakeFromNib() {
    super.awakeFromNib()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
