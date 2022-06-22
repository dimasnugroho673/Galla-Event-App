//
//  HomeViewController.swift
//  Galla
//
//  Created by Dimas Putro on 22/06/22.
//

import UIKit

class HomeViewController: UIViewController {

  lazy var scrollView: UIScrollView = {
    let sv = UIScrollView(frame: .zero)
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.bounces = true
    sv.backgroundColor = UIColor(named: "color-background")

    return sv
  }()

  lazy var containerView: UIView = {
    let sv = UIView()
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.backgroundColor = UIColor(named: "color-background")

    return sv
  }()

  lazy var nearEventLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Find event near"
    label.font = UIFont(name: "Poppins-Regular", size: 14)
    label.textColor = UIColor.systemGray2

    return label
  }()

  lazy var myLocationHeader: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false

    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Bandung, ID"
    label.font = UIFont(name: "Poppins-SemiBold", size: 20)
    label.textColor = UIColor(named: "color-black")

    let image = UIImageView()
    let config = UIImage.SymbolWeight.bold
    image.translatesAutoresizingMaskIntoConstraints = false
    image.image = UIImage(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration.init(weight: config))
    image.tintColor = UIColor(named: "color-black")

    view.addSubview(label)
    view.addSubview(image)

    image.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0).isActive = true
    image.leftAnchor.constraint(equalTo: label.rightAnchor, constant: 5).isActive = true

    return view
  }()

  lazy var profileImage: UIImageView = {
    let img = UIImageView()
    img.translatesAutoresizingMaskIntoConstraints = false
    img.widthAnchor.constraint(equalToConstant: 48).isActive = true
    img.heightAnchor.constraint(equalToConstant: 48).isActive = true
    img.image = UIImage(named: "dummy-profile")
    img.backgroundColor = UIColor.systemGray3
    img.layer.cornerRadius = 48 / 2
    img.clipsToBounds = true

    return img
  }()

  lazy var placeholderSearchLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Search all events..."
    label.font = UIFont(name: "Poppins-Regular", size: 14)
    label.textColor = .systemGray2

    return label
  }()

  lazy var placeholderSearchImage: UIImageView = {
    let img = UIImageView()
    img.translatesAutoresizingMaskIntoConstraints = false
    img.image = UIImage(named: "icon-search")
    img.widthAnchor.constraint(equalToConstant: 18).isActive = true
    img.heightAnchor.constraint(equalToConstant: 18).isActive = true

    return img
  }()

  lazy var searchTextField: UITextField = {
    let tf = UITextField()

    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.backgroundColor = UIColor.white
    tf.heightAnchor.constraint(equalToConstant: 54).isActive = true
    tf.layer.cornerRadius = 12
    tf.font = UIFont(name: "Poppins-Regular", size: 14)

    return tf
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Home"
    navigationController?.navigationBar.isHidden = true

    view.addSubview(scrollView)
    scrollView.addSubview(containerView)

    let myLoationStack = UIStackView(arrangedSubviews: [nearEventLabel, myLocationHeader])
    myLoationStack.translatesAutoresizingMaskIntoConstraints = false
    myLoationStack.axis = .vertical
    myLoationStack.spacing = 3

    let searchPlaceholderStack = UIStackView(arrangedSubviews: [placeholderSearchImage, placeholderSearchLabel])
    searchPlaceholderStack.translatesAutoresizingMaskIntoConstraints = false
    searchPlaceholderStack.axis = .horizontal
    searchPlaceholderStack.spacing = 15

    containerView.addSubview(myLoationStack)
    containerView.addSubview(profileImage)
    containerView.addSubview(searchTextField)
    searchTextField.addSubview(searchPlaceholderStack)
    searchTextField.setLeftPaddingPoints(45)

    NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextField.textDidChangeNotification, object: nil)

    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
      scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
      scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),

      containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
      containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
      containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0),
      containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0),
      containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
      containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

      myLoationStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
      myLoationStack.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),

      profileImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
      profileImage.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),

      searchTextField.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
      searchTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
      searchTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),

      searchPlaceholderStack.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor, constant: 0),
      searchPlaceholderStack.leftAnchor.constraint(equalTo: searchTextField.leftAnchor, constant: 13)
    ])
  }

  @objc func handleTextInputChange() {
    placeholderSearchLabel.isHidden = !searchTextField.text!.isEmpty
  }



}


extension UITextField {
  func setLeftPaddingPoints(_ amount:CGFloat){
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
    self.leftView = paddingView
    self.leftViewMode = .always
  }
  func setRightPaddingPoints(_ amount:CGFloat) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
    self.rightView = paddingView
    self.rightViewMode = .always
  }
}
