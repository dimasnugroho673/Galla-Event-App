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

  func showSpinner(containerView: UIView, isAnimating: Bool, backgroundColor: UIColor = .black) -> UIActivityIndicatorView {
    let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    spinner.style = .large
    spinner.color = .white
    spinner.center = containerView.center
    spinner.backgroundColor = backgroundColor
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

  static func generateBarcode(from string: String) -> UIImage? {
    let data = string.data(using: String.Encoding.ascii)

    //    if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
    //        filter.setValue(data, forKey: "inputMessage")
    //        let transform = CGAffineTransform(scaleX: 3, y: 3)
    //
    //        if let output = filter.outputImage?.transformed(by: transform) {
    //            return UIImage(ciImage: output)
    //        }
    //    }

    if let filter = CIFilter(name: "CICode128BarcodeGenerator") {

      guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }

              filter.setValue(data, forKey: "inputMessage")

//              filter.setValue("H", forKey: "inputCorrectionLevel")
              colorFilter.setValue(filter.outputImage, forKey: "inputImage")
              colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1, alpha: 0), forKey: "inputColor1") // Background white
              colorFilter.setValue(CIColor(color: UIColor(hexString: "3F3D56")), forKey: "inputColor0") // Foreground or the barcode RED

//              let scaleX = imgQRCode.frame.size.width / qrCodeImage.extent.size.width
//              let scaleY = imgQRCode.frame.size.height / qrCodeImage.extent.size.height

              let transform = CGAffineTransform(scaleX: 3, y: 3)

              if let output = colorFilter.outputImage?.transformed(by: transform) {
                  return UIImage(ciImage: output)
              }


//      filter.setValue(data, forKey: "inputMessage")
//
//      let transform = CGAffineTransform(scaleX: 3, y: 3)
//
//      if let outputBarcode = filter.outputImage?.transformed(by: transform) {
//        let invertFilter = CIFilter(name: "CIColorInvert")!
//        invertFilter.setValue(outputBarcode, forKey: kCIInputImageKey)
//
//        if let outputInvert = invertFilter.outputImage?.transformed(by: transform) {
//          let mask = CIFilter(name: "CIMaskToAlpha")!
//          mask.setValue(outputInvert, forKey: kCIInputImageKey)
//
////          guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
////          colorFilter.setValue(mask.outputImage, forKey: "inputImage")
////          colorFilter.setValue(CIColor(red: 64, green: 60, blue: 88), forKey: "inputColor0") // Foreground or the barcode RED
//
//          return UIImage(ciImage: (mask.outputImage?.transformed(by: transform))!) //TODO: Remove force unwrap
////          return UIImage(ciImage: (colorFilter.outputImage?.transformed(by: transform))!) //TODO: Remove force unwrap
//        }
//      }
    }

    return nil
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
