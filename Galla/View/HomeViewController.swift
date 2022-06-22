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
    label.textColor = UIColor.systemGray3

    return label
  }()

  lazy var myLocationLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Bandung, ID"
    label.font = UIFont(name: "Poppins-SemiBold", size: 20)
    label.textColor = UIColor(named: "color-black")

    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Home"
    navigationController?.navigationBar.isHidden = true

    view.addSubview(scrollView)
    scrollView.addSubview(containerView)

    let myLoationStack = UIStackView(arrangedSubviews: [nearEventLabel, myLocationLabel])
    myLoationStack.translatesAutoresizingMaskIntoConstraints = false
    myLoationStack.axis = .vertical
    myLoationStack.spacing = 5

    containerView.addSubview(myLoationStack)

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
      myLoationStack.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15)

    ])
  }



}
