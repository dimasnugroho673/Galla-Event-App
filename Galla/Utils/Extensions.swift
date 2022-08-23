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

extension UIView {
  func viewToImage(view: UIView) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
    defer { UIGraphicsEndImageContext() }
    view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
    return UIGraphicsGetImageFromCurrentImageContext()
  }
}

extension UIImage {
  func saveToPhotoLibrary(_ completionTarget: Any?, _ completionSelector: Selector?) {
    DispatchQueue.global(qos: .userInitiated).async {
      UIImageWriteToSavedPhotosAlbum(self, completionTarget, completionSelector, nil)
    }
  }
}

extension String {
  func locationEventCustom(location: String, country: String) -> String {
    var locationNew = location
    locationNew = locationNew.replacingOccurrences(of: "KOTA ", with: "")
    locationNew = locationNew.replacingOccurrences(of: "KAB. ", with: "")
    locationNew = locationNew.capitalized

    return "\(locationNew), \(country.uppercased())"
  }

  func toSecond(dateFormat: String = "yyyy-MM-dd HH:mm:ss", timeZone: String? = nil) -> TimeInterval? {
    // building the formatter
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    if let timeZone = timeZone { formatter.timeZone = TimeZone(identifier: timeZone) }

    // extracting the epoch
    let date = formatter.date(from: self)
    return date?.timeIntervalSince1970
  }
}

extension NSTextAttachment {
  func setLeftImage(color: UIColor = UIColor(named: "color-background")!, text: String, imageString: String, imageType: ImageTypeTextFieldEnum, offsetX: CGFloat = 0.0, offsetY: CGFloat = 0.0) -> NSMutableAttributedString {
    // Create Attachment
    let imageAttachment = NSTextAttachment()

    if imageType == .named {
      imageAttachment.image = UIImage(named: imageString)

      // Set bound to reposition
      let offsetY = offsetY == 0.0 ? -7.0 : offsetY
      imageAttachment.bounds = CGRect(x: 0, y: offsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
    } else {
      imageAttachment.image = UIImage(systemName: imageString)?.withTintColor(color)

      // Set bound to reposition
      let offsetY = offsetY == 0.0 ? -5.0 : offsetY
      imageAttachment.bounds = CGRect(x: 0, y: offsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
    }

    // Create string with attachment
    let attachmentString = NSAttributedString(attachment: imageAttachment)
    // Initialize mutable string
    let completeText = NSMutableAttributedString(string: "")
    // Add image to mutable string
    completeText.append(attachmentString)
    // Add your text to mutable string
    let textAfterIcon = NSAttributedString(string: "  " + text, attributes: [.foregroundColor: color])
    completeText.append(textAfterIcon)

    return completeText
  }
}

extension UILabel {
  func colorString(text: String, coloredText: String, changeTextTo: String?, color: UIColor? = .red, textStyle: UIFont = UIFont(name: "Poppins", size: 12)!) {

    let attributedString = NSMutableAttributedString(string: text)
    let range = (text as NSString).range(of: coloredText)
    attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color!, NSAttributedString.Key.font: textStyle],
                                   range: range)

    if changeTextTo != "" {
      // Replace replaceable content in mutableAttributedString with new content
      let totalRange = NSRange(location: 0, length: attributedString.string.count)
      _ = attributedString.mutableString.replaceOccurrences(of: coloredText, with: changeTextTo!, options: [], range: totalRange)
    }

    self.attributedText = attributedString
  }

  func colorAttributeString(text: NSAttributedString, coloredText: String, changeTextTo: String?, color: UIColor? = .red, textStyle: UIFont = UIFont(name: "Poppins", size: 12)!) {

    let attributedString = NSMutableAttributedString(attributedString: text)
    let range = (text.string as NSString).range(of: coloredText)
    attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color!, NSAttributedString.Key.font: textStyle],
                                   range: range)

    if changeTextTo != "" {
      // Replace replaceable content in mutableAttributedString with new content
      let totalRange = NSRange(location: 0, length: attributedString.string.count)
      _ = attributedString.mutableString.replaceOccurrences(of: coloredText, with: changeTextTo!, options: [], range: totalRange)
    }

    self.attributedText = attributedString
  }

//  func colorWords(string: String, coloredTexts: [String], changeTextsTo: [String?], colors: [UIColor?] = [.red], textStyles: [UIFont] = [UIFont(name: "Poppins", size: 12)!]) {
//
//    var index: Int = 0
//
//    var tmp: NSAttributedString = NSAttributedString(string: string)
//
//    while index < coloredTexts.count {
//
//      let attributedString = NSMutableAttributedString(string: string)
//      let range = (string as NSString).range(of: coloredTexts[index])
//      attributedString.setAttributes([NSAttributedString.Key.foregroundColor: colors[index]!, NSAttributedString.Key.font: textStyles[index]], range: range)
//
//      if changeTextsTo[index] != "" {
//        attributedString.mutableString.replaceOccurrences(of: coloredTexts[index], with: changeTextsTo[index]!, options: [], range: range)
//      }
//
////      self.attributedText = attributedString
//      tmp = attributedString
//
//      index = index + 1
//    }
//
//    self.attributedText = tmp
//
//
//  }
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

enum TicketCanceledEnum {
  case all
  case canceled
  case notCanceled

  var cancelTicketType: Bool? {
    switch self {
    case .all:
      return nil
    case .canceled:
      return true
    case .notCanceled:
      return false
    }
  }
}
