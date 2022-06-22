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
}
