//
//  JoinedViewController.swift
//  Galla
//
//  Created by Dimas Putro on 29/06/22.
//

import UIKit
import SwiftUI

class JoinedViewController: UIViewController {

  lazy var ilustrationImage: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.image = UIImage(named: "img-booked")
    image.contentMode = .scaleAspectFill

    return image
  }()

  lazy var emotionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Well Booked 😍"
    label.font = UIFont(name: "Poppins-SemiBold", size: 24)
    label.textColor = UIColor(named: "color-black")

    return label
  }()

  lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "See you later on this event, we hopefully you can attend 👋"
    label.font = UIFont(name: "Poppins-Regular", size: 13)
    label.textColor = .systemGray
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .center

    return label
  }()

  let ctaButton: UIButton = CTAButton(title: "See My Ticket")

  override func viewDidLoad() {
    super.viewDidLoad()

    configureUI()
  }

  func configureUI() {
    view.backgroundColor = UIColor(named: "color-background")

    view.addSubview(ctaButton)
    view.addSubview(ilustrationImage)
    view.addSubview(emotionLabel)
    view.addSubview(descriptionLabel)

    ctaButton.addTarget(self, action: #selector(handleCTAButtonTapped), for: .touchUpInside)

    NSLayoutConstraint.activate([
      ctaButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
      ctaButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
      ctaButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),

      ilustrationImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
      ilustrationImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
      ilustrationImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),

      emotionLabel.topAnchor.constraint(equalTo: ilustrationImage.bottomAnchor, constant: 40),
      emotionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      descriptionLabel.topAnchor.constraint(equalTo: emotionLabel.bottomAnchor, constant: 10),
      descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35),
      descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35),
    ])
  }

  @objc func handleCTAButtonTapped() {
    navigationController?.popToRootViewController(animated: true)
  }
}

struct BestInClassPreviews_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      UIViewControllerPreview {
        // Return whatever controller you want to preview
        let vc = JoinedViewController()
        return vc
      }
      .previewDevice("iPhone 12")
      UIViewControllerPreview {
        // Return whatever controller you want to preview
        let vc = JoinedViewController()
        return vc
      }
      .previewDevice("iPod touch (7th generation)")
    }
  }
}
