//
//  PreviewViewController.swift
//  Galla
//
//  Created by Dimas Putro on 29/06/22.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
  func updateUIViewController(_ uiViewController: ViewController, context: Context) {}

  let viewController: ViewController

  init(_ builder: @escaping () -> ViewController) {
    viewController = builder()
  }
  
  // MARK: - UIViewControllerRepresentable
  func makeUIViewController(context: Context) -> ViewController {
    viewController
  }
}
#endif
