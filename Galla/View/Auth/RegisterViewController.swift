//
//  RegisterViewController.swift
//  Galla
//
//  Created by Dimas Putro on 22/06/22.
//

import UIKit

class RegisterViewController: UIViewController {

  lazy var scrollView: UIScrollView = {
    let sv = UIScrollView(frame: .zero)
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.bounces = true
    sv.backgroundColor = UIColor(named: "color-background")

    return sv
  }()

  lazy var fullnameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Fullname"
    label.textColor = UIColor(hexString: "535353")
    label.font = UIFont(name: "Poppins-Regular", size: 14)

    return label
  }()

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

  lazy var confirmPasswordLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Confirm password"
    label.textColor = UIColor(hexString: "535353")
    label.font = UIFont(name: "Poppins-Regular", size: 14)

    return label
  }()

  lazy var fullnameTextField: UITextField = {
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

  lazy var confirmPasswordTextField: UITextField = {
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


  lazy var haveAccountButton: UIButton = {
    let button = Utilities().attributedButton("Have an account?", " Sign in now")
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(handleGoToSignIn), for: .touchUpInside)

    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    configureUI()
  }

  func configureUI() {
    navigationController?.navigationBar.isHidden = true
    view.backgroundColor = UIColor(named: "color-background")

    let header = HeaderBackgroundAuth(title: "Sign up.", subtitle: "to find funny events.", imageBackground: UIImage(named: "img-sign-up")!, width: view.frame.size.width)
    let registerButton = CTAButton(title: "Create account")

    view.addSubview(scrollView)
    scrollView.contentInsetAdjustmentBehavior = .never
    scrollView.addSubview(header)
    scrollView.addSubview(fullnameLabel)
    scrollView.addSubview(fullnameTextField)
    scrollView.addSubview(emailLabel)
    scrollView.addSubview(emailTextField)
    scrollView.addSubview(passwordLabel)
    scrollView.addSubview(passwordTextField)
    scrollView.addSubview(confirmPasswordLabel)
    scrollView.addSubview(confirmPasswordTextField)
    scrollView.addSubview(registerButton)
    scrollView.addSubview(haveAccountButton)

    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
      scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
      scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),

      header.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
      header.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0),
      header.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0),

      fullnameLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 25),
      fullnameLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 23),

      fullnameTextField.topAnchor.constraint(equalTo: fullnameLabel.bottomAnchor, constant: 4.5),
      fullnameTextField.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 23),
      fullnameTextField.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -23),

      emailLabel.topAnchor.constraint(equalTo: fullnameTextField.bottomAnchor, constant: 15),
      emailLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 23),

      emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4.5),
      emailTextField.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 23),
      emailTextField.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -23),

      passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
      passwordLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 23),

      passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 4.5),
      passwordTextField.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 23),
      passwordTextField.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -23),

      confirmPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
      confirmPasswordLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 23),

      confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 4.5),
      confirmPasswordTextField.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 23),
      confirmPasswordTextField.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -23),

      registerButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 29),
      registerButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 23),
      registerButton.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -23),

      haveAccountButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 15),
      haveAccountButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0),
      haveAccountButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -40),
    ])
  }

  @objc func handleGoToSignIn() {
    navigationController?.popViewController(animated: true)
  }

}
