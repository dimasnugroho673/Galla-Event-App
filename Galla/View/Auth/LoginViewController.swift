//
//  LoginViewController.swift
//  Galla
//
//  Created by Dimas Putro on 22/06/22.
//

import UIKit

class LoginViewController: UIViewController {

  lazy var emailLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Email"
    label.textColor = UIColor(hexString: "535353")
    label.font = UIFont(name: "Poppins-Regular", size: 14)

    return label
  }()

  lazy var passwordLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Password"
    label.textColor = UIColor(hexString: "535353")
    label.font = UIFont(name: "Poppins-Regular", size: 14)

    return label
  }()

  lazy var emailTextField: UITextField = {
    let tf = UITextField()
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.backgroundColor = UIColor.white
    tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
    tf.layer.cornerRadius = 12
    tf.font = UIFont(name: "Poppins-Regular", size: 14)
    tf.textColor = UIColor(hexString: "535353")
    tf.setLeftPaddingPoints(10)
    tf.layer.borderColor = UIColor(hexString: "535353").withAlphaComponent(0.1).cgColor
    tf.layer.borderWidth = 0.8

    return tf
  }()

  lazy var passwordTextField: UITextField = {
    let tf = UITextField()
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.backgroundColor = UIColor.white
    tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
    tf.layer.cornerRadius = 12
    tf.font = UIFont(name: "Poppins-Regular", size: 14)
    tf.textColor = UIColor(hexString: "535353")
    tf.setLeftPaddingPoints(10)
    tf.isSecureTextEntry = true
    tf.layer.borderColor = UIColor(hexString: "535353").withAlphaComponent(0.1).cgColor
    tf.layer.borderWidth = 0.8

    return tf
  }()

  lazy var dontHaveAccountButton: UIButton = {
    let button = Utilities().attributedButton("Don't have an account?", " Create account now")
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(handleCreateAccount), for: .touchUpInside)

    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    configureUI()
  }

  func configureUI() {
    view.backgroundColor = UIColor(named: "color-background")

    let header = HeaderBackgroundAuth(title: "Sign in.", subtitle: "to join all event.", imageBackground: UIImage(named: "img-sign-in")!, width: view.frame.size.width)
    let loginButton = CTAButton(title: "Sign in")

    view.addSubview(header)
    view.addSubview(emailLabel)
    view.addSubview(emailTextField)
    view.addSubview(passwordLabel)
    view.addSubview(passwordTextField)
    view.addSubview(loginButton)
    view.addSubview(dontHaveAccountButton)

    NSLayoutConstraint.activate([
      header.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
      header.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
      header.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),

      emailLabel.topAnchor.constraint(equalTo: header.darkenLayerView.bottomAnchor, constant: 25),
      emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 23),

      emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4.5),
      emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 23),
      emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -23),

      passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
      passwordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 23),

      passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 4.5),
      passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 23),
      passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -23),

      loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 29),
      loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 23),
      loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -23),

      dontHaveAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
      dontHaveAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
    ])
  }

  @objc func handleCreateAccount() {
    let vc = RegisterViewController()
    navigationController?.pushViewController(vc, animated: true)
  }

}
