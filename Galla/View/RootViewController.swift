//
//  ViewController.swift
//  Galla
//
//  Created by Dimas Putro on 22/06/22.
//

import UIKit

class RootViewController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let home = templateTabBar(with: "Home", image: UIImage(named: "icon-home"), selectedImage: UIImage(named: "icon-home-active"), viewController: HomeViewController())
    let explore = templateTabBar(with: "Explore", image: UIImage(named: "icon-search"), selectedImage: UIImage(named: "icon-search-active"), viewController: EmptyViewController())
    let favorite = templateTabBar(with: "Favorite", image: UIImage(named: "icon-favorite"), selectedImage: UIImage(named: "icon-favorite-active"), viewController: EmptyViewController())
    let ticket = templateTabBar(with: "Ticket", image: UIImage(named: "icon-ticket"), selectedImage: UIImage(named: "icon-ticket-active"), viewController: EmptyViewController())
    let profile = templateTabBar(with: "Profile", image: UIImage(named: "icon-people"), selectedImage: UIImage(named: "icon-people-active"), viewController: EmptyViewController())

    setViewControllers([home, explore, favorite, ticket, profile], animated: false)

    configureUI()
  }

  private func configureUI() {
    if #available(iOS 15.0, *) {
      let tabBarAppearance = UITabBarAppearance()
      tabBarAppearance.configureWithOpaqueBackground()
      UITabBar.appearance().standardAppearance = tabBarAppearance
      UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
      UITabBar.appearance().tintColor = UIColor(named: "color-primary")
      UITabBar.appearance().isTranslucent = false
      UITabBar.appearance().backgroundImage = UIImage()
      UITabBar.appearance().shadowImage = UIImage()
    }


  }

  private func templateTabBar(with title: String, image: UIImage?, selectedImage: UIImage?, viewController: UIViewController) -> UINavigationController {
    let nav = UINavigationController(rootViewController: viewController)

    nav.tabBarItem.title = title
    nav.tabBarItem.image = image
    nav.tabBarItem.selectedImage = selectedImage

    return nav
  }

}

