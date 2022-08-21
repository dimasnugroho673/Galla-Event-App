//
//  Spinner.swift
//  Galla
//
//  Created by Dimas Putro on 25/06/22.
//

import UIKit

let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))

extension UIViewController {
  func showSpinner(style: UIActivityIndicatorView.Style = .large, color: UIColor = .white, backgroundColor: UIColor = .black) {
    spinner.style = style
    spinner.color = color
    spinner.center = view.center
    spinner.backgroundColor = backgroundColor
    spinner.layer.cornerRadius = 12
    spinner.hidesWhenStopped = true
    spinner.startAnimating()
    
    view.addSubview(spinner)
  }

  func removeSpinner() {
    spinner.stopAnimating()
  }
}

