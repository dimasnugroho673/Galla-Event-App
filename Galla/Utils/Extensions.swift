//
//  Extensions.swift
//  Galla
//
//  Created by Dimas Putro on 22/06/22.
//

import UIKit

extension UIColor {
  convenience init(hexString: String) {
    let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int = UInt64()
    Scanner(string: hex).scanHexInt64(&int)
    let a, r, g, b: UInt64
    switch hex.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (255, 0, 0, 0)
    }
    self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
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

extension UITextField {
  func setLeftImage(imageString: String, imageType: ImageTypeTextFieldEnum) {
//    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    let imageViewContainer = UIView()
    imageViewContainer.translatesAutoresizingMaskIntoConstraints = false

    imageViewContainer.widthAnchor.constraint(equalToConstant: 30).isActive = true
    imageViewContainer.heightAnchor.constraint(equalToConstant: 25).isActive = true

    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false

    if imageType == .named {
      imageView.image = UIImage(named: imageString)
    } else {
      imageView.image = UIImage(systemName: imageString)
    }

    imageViewContainer.addSubview(imageView)

    imageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
    imageView.centerXAnchor.constraint(equalTo: imageViewContainer.centerXAnchor).isActive = true
    imageView.centerYAnchor.constraint(equalTo: imageViewContainer.centerYAnchor).isActive = true

    self.leftView = imageViewContainer;
    self.leftViewMode = .always
  }

  func setDeleteImage(imageString: String, imageType: ImageTypeTextFieldEnum) {
//    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    let imageViewContainer = UIView()
    imageViewContainer.translatesAutoresizingMaskIntoConstraints = false

    imageViewContainer.widthAnchor.constraint(equalToConstant: 35).isActive = true
    imageViewContainer.heightAnchor.constraint(equalToConstant: 35).isActive = true

    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
    imageView.tintColor = .gray

    if imageType == .named {
      imageView.image = UIImage(named: imageString)
    } else {
      imageView.image = UIImage(systemName: imageString)
    }

    imageViewContainer.addSubview(imageView)

    imageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
    imageView.centerXAnchor.constraint(equalTo: imageViewContainer.centerXAnchor).isActive = true
    imageView.centerYAnchor.constraint(equalTo: imageViewContainer.centerYAnchor).isActive = true

    self.rightView = imageViewContainer;
    self.rightViewMode = .always
  }
}

enum ImageTypeTextFieldEnum {
  case systemName
  case named

  var imageType: String? {
    switch self {
      case .named:
        return "named"
      case .systemName:
        return "systemName"
      }
  }
}
