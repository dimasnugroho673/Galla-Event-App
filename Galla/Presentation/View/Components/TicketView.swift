//
//  TicketView.swift
//  Galla
//
//  Created by Dimas Putro on 15/08/22.
//

import UIKit

class TicketView: UIView {

  var width: CGFloat
  var ticket: Ticket

  private lazy var header: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false

    view.clipsToBounds = true
    view.layer.cornerRadius = 18
    view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    view.backgroundColor = UIColor(hexString: "DC6837")

    return view
  }()

  private lazy var body: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false

    view.clipsToBounds = true
    view.layer.cornerRadius = 18
    view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    view.backgroundColor = UIColor(hexString: "FFCC4C")

    return view
  }()

  private lazy var footer: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false

    view.clipsToBounds = true
    view.layer.cornerRadius = 18
    view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    view.backgroundColor = UIColor(hexString: "D79710")

    return view
  }()

  private lazy var nameEventLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Dancing in The Moon"
    label.font = UIFont(name: "Poppins-Bold", size: 16)
    label.textColor = .white

    return label
  }()

  private lazy var dateEventLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Tuesday,  28 Aug 2022 | 18.00"
    label.font = UIFont(name: "Poppins-Medium", size: 13)
    label.textColor = UIColor(named: "color-background")

    return label
  }()

  private lazy var locationEventLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Lagoi Bay, Bintan"
    label.font = UIFont(name: "Poppins-Medium", size: 13)
    label.textColor = UIColor(named: "color-background")

    return label
  }()

  private lazy var transactionCodeTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Transaction Code"
    label.font = UIFont(name: "Poppins-SemiBold", size: 12)
    label.textAlignment = .center
    label.textColor = UIColor(hexString: "3F3D56")

    return label
  }()

  private lazy var transactionCodeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = ""
    label.font = UIFont(name: "Poppins-ExtraBold", size: 16)
    label.textAlignment = .center
    label.textColor = UIColor(hexString: "3F3D56")

    return label
  }()

  private lazy var saveTicketButton: UIButton = {
    let btn = UIButton(type: .system)
    btn.translatesAutoresizingMaskIntoConstraints = false

    btn.widthAnchor.constraint(equalToConstant: 40).isActive = true
    btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
    btn.clipsToBounds = true
    btn.layer.cornerRadius = 40 / 2
    btn.backgroundColor = UIColor(hexString: "EEB847")

    let image = UIImage(named: "icon-download")?.withRenderingMode(.alwaysTemplate)
    btn.setImage(image, for: .normal)
    btn.tintColor = UIColor(hexString: "3F3D56")

    btn.addTarget(self, action: #selector(handleSave), for: .touchUpInside)

    return btn
  }()

  lazy var clip1: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.heightAnchor.constraint(equalToConstant: 40).isActive = true
    view.widthAnchor.constraint(equalToConstant: 40).isActive = true
    view.clipsToBounds = true
    view.layer.cornerRadius = 40 / 2
    view.backgroundColor = UIColor(named: "color-background")

    return view
  }()

  lazy var clip2: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.heightAnchor.constraint(equalToConstant: 40).isActive = true
    view.widthAnchor.constraint(equalToConstant: 40).isActive = true
    view.clipsToBounds = true
    view.layer.cornerRadius = 40 / 2
    view.backgroundColor = UIColor(named: "color-background")

    return view
  }()

  init(width: CGFloat, ticket: Ticket) {
    self.width = width
    self.ticket = ticket

    super.init(frame: .zero)

    configureUI()
    configureData()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureUI() {
    translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(header)
    addSubview(footer)
    addSubview(body)
    body.addSubview(saveTicketButton)

    header.addSubview(nameEventLabel)

    heightAnchor.constraint(equalToConstant: 380).isActive = true
    widthAnchor.constraint(equalToConstant: width).isActive = true

    header.heightAnchor.constraint(equalToConstant: 158).isActive = true
    header.widthAnchor.constraint(equalToConstant: width).isActive = true

    body.heightAnchor.constraint(equalToConstant: 208).isActive = true
    body.widthAnchor.constraint(equalToConstant: width).isActive = true

    footer.heightAnchor.constraint(equalToConstant: 221).isActive = true
    footer.widthAnchor.constraint(equalToConstant: width - 30).isActive = true

    let dash = UIStackView(arrangedSubviews: [])
    dash.translatesAutoresizingMaskIntoConstraints = false
    dash.axis = .horizontal
    dash.distribution = .equalCentering
    dash.spacing = 5

    addSubview(dash)

    for _ in 1...20 {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.heightAnchor.constraint(equalToConstant: 3).isActive = true
      view.widthAnchor.constraint(equalToConstant: 10).isActive = true
      view.backgroundColor = UIColor(named: "color-background")
      view.clipsToBounds = true
      view.layer.cornerRadius = 3 / 2

      dash.addArrangedSubview(view)
    }

    let bodyClipStack = UIStackView(arrangedSubviews: [])
    bodyClipStack.translatesAutoresizingMaskIntoConstraints = false
    bodyClipStack.axis = .horizontal
    bodyClipStack.distribution = .equalCentering
    bodyClipStack.spacing = 10

    addSubview(bodyClipStack)

    bodyClipStack.addArrangedSubview(clip1)
    bodyClipStack.addArrangedSubview(clip2)

    let separateUID = ticket.uid.split(separator: "-")
    let barcode = Utilities.generateBarcode(from: "\(ticket.transactionCode).\(separateUID[0])")

    let image = UIImageView(image: barcode)
    image.translatesAutoresizingMaskIntoConstraints = false
    image.heightAnchor.constraint(equalToConstant: 80).isActive = true
    image.backgroundColor = .clear

    let transactionCodeStack = UIStackView(arrangedSubviews: [transactionCodeTitleLabel, transactionCodeLabel, image])
    transactionCodeStack.translatesAutoresizingMaskIntoConstraints = false
    transactionCodeStack.axis = .vertical
    transactionCodeStack.spacing = 5

    addSubview(transactionCodeStack)

//    for _ in 1...2 {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        view.clipsToBounds = true
//        view.layer.cornerRadius = 40 / 2
//        view.backgroundColor = UIColor(named: "color-background")
//
//        bodyClipStack.addArrangedSubview(view)
//    }


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

    header.addSubview(dateEventLabel)
    header.addSubview(locationEventLabel)

    NSLayoutConstraint.activate([
      header.topAnchor.constraint(equalTo: topAnchor),
      header.rightAnchor.constraint(equalTo: rightAnchor),
      header.leftAnchor.constraint(equalTo: leftAnchor),

      footer.topAnchor.constraint(equalTo: header.bottomAnchor),
      footer.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
      footer.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
//      footer.bottomAnchor.constraint(equalTo: bottomAnchor),

      body.topAnchor.constraint(equalTo: footer.topAnchor),
      body.rightAnchor.constraint(equalTo: rightAnchor),
      body.leftAnchor.constraint(equalTo: leftAnchor),

      bodyClipStack.widthAnchor.constraint(equalToConstant: width),
      bodyClipStack.topAnchor.constraint(equalTo: header.bottomAnchor, constant: -20),
      bodyClipStack.leftAnchor.constraint(equalTo: leftAnchor, constant: -15),
      bodyClipStack.rightAnchor.constraint(equalTo: rightAnchor, constant: 15),

      dash.widthAnchor.constraint(equalToConstant: width - 30),
      dash.topAnchor.constraint(equalTo: body.topAnchor, constant: -1.5),
      dash.rightAnchor.constraint(equalTo: bodyClipStack.rightAnchor),
      dash.leftAnchor.constraint(equalTo: bodyClipStack.leftAnchor),

      nameEventLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: 22),
      nameEventLabel.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 22),
      nameEventLabel.rightAnchor.constraint(equalTo: header.rightAnchor, constant: -22),

      dateEventLabel.topAnchor.constraint(equalTo: nameEventLabel.bottomAnchor, constant: 20),
      dateEventLabel.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 22),
      dateEventLabel.rightAnchor.constraint(equalTo: header.rightAnchor, constant: -22),

      locationEventLabel.topAnchor.constraint(equalTo: dateEventLabel.bottomAnchor, constant: 10),
      locationEventLabel.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 22),
      locationEventLabel.rightAnchor.constraint(equalTo: header.rightAnchor, constant: -22),

      transactionCodeStack.topAnchor.constraint(equalTo: body.topAnchor, constant: 15),
      transactionCodeStack.leftAnchor.constraint(equalTo: body.leftAnchor, constant: 20),
      transactionCodeStack.rightAnchor.constraint(equalTo: body.rightAnchor, constant: -20),

      saveTicketButton.bottomAnchor.constraint(equalTo: body.bottomAnchor, constant: -15),
      saveTicketButton.centerXAnchor.constraint(equalTo: body.centerXAnchor)
    ])
  }

  func configureData() {
    nameEventLabel.text = ticket.name

    let date = NSTextAttachment().setLeftImage(text: "Tuesday,  28 Aug 2022 | 18.00", imageString: "clock", imageType: .systemName)
    let location = NSTextAttachment().setLeftImage(text: "\(ticket.location.venue), \(String().locationEventCustom(location: ticket.location.regency.name, country: "ID"))", imageString: "icon-location-line", imageType: .named)

    dateEventLabel.attributedText = date
    locationEventLabel.attributedText = location

    let transactionCode = NSMutableAttributedString(string: ticket.transactionCode)
    transactionCode.addAttribute(NSAttributedString.Key.kern, value: CGFloat(3), range: NSRange(location: 0, length: ticket.transactionCode.count))

    transactionCodeLabel.attributedText = transactionCode
  }

  @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//      if let error = error {
//          // we got back an error!
////          let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
////          ac.addAction(UIAlertAction(title: "OK", style: .default))
////          present(ac, animated: true)
//      } else {
////          let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
////          ac.addAction(UIAlertAction(title: "OK", style: .default))
////          present(ac, animated: true)
//      }

//    self.clip1.backgroundColor = UIColor(named: "color-background")
//    self.clip2.backgroundColor = UIColor(named: "color-background")
    saveTicketButton.isHidden = false
  }

  @objc func handleSave() {
    print("DEBUG: Saved...")
    let view = self
    view.backgroundColor = UIColor(named: "color-background")
    saveTicketButton.isHidden = true

    let image = viewToImage(view: view) ?? UIImage()

    UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
  }
}
