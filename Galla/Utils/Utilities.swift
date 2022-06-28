//
//  Utilities.swift
//  Galla
//
//  Created by Dimas Putro on 22/06/22.
//

import UIKit

class Utilities {
  func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
    let button = UIButton(type: .system)

    let attributedTitle = NSMutableAttributedString(string: firstPart + secondPart, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor(named: "color-black") ?? UIColor.black])
    
    attributedTitle.addAttribute(NSAttributedString.Key.underlineStyle,
                                        value: NSUnderlineStyle.single.rawValue,
                                        range: NSMakeRange(0, attributedTitle.length))

    button.setAttributedTitle(attributedTitle, for: .normal)

    return button
  }

  func showAlert(title: String, message: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default))

    return alert
  }

  func showSpinner(containerView: UIView, isAnimating: Bool) -> UIActivityIndicatorView {
    let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    spinner.style = .large
    spinner.color = .white
    spinner.center = containerView.center
    spinner.backgroundColor = .black
    spinner.layer.cornerRadius = 12
//    spinner.hidesWhenStopped = true
    
//    if isAnimating {
//      spinner.startAnimating()
//    } else {
////      spinner.stopAnimating()
//    }

    containerView.addSubview(spinner)

    return spinner
  }

  static func validateEmail(candidate: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
  }

  static func formatterDate(dateInString: String, inFormat: String, toFormat format: String) -> String? {
    let inputDateFormatter = DateFormatter()
    inputDateFormatter.dateFormat = inFormat

    if let date = inputDateFormatter.date(from: dateInString) {
      let outputDateFormatter = DateFormatter()
      outputDateFormatter.dateFormat = format

      return outputDateFormatter.string(from: date)
    }
    return nil
  }
}
