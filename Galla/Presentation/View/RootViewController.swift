//
//  ViewController.swift
//  Galla
//
//  Created by Dimas Putro on 22/06/22.
//

import UIKit

class RootViewController: UITabBarController {
  
  let authViewModel: UserViewModel = UserViewModel(userUseCase: Injection().provideAuth())
  
  fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    checkIsLogin()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    let newTabBarHeight = defaultTabBarHeight + 8
    
    var newFrame = tabBar.frame
    newFrame.size.height = newTabBarHeight
    newFrame.origin.y = view.frame.size.height - newTabBarHeight
    
    tabBar.frame = newFrame
    
    tabBar.shadowImage = UIImage()
    tabBar.layer.borderWidth = 0
    tabBar.layer.borderColor = UIColor.clear.cgColor
    tabBar.layer.shadowColor = UIColor.black.cgColor
    tabBar.layer.shadowRadius = 10
    tabBar.layer.shadowOpacity = 0.1
    tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
    tabBar.layer.masksToBounds = false
    tabBar.clipsToBounds = true
  }
  
  func configureUIandTabBar() {
    self.configureUI()
    self.configureTabBar()
  }
  
  func checkIsLogin() {
    authViewModel.isLogin()
    
    authViewModel.isLoggedIn.bind { result in
      if result {
        // fetch data
        self.configureUI()
        self.configureTabBar()
      } else {
        // present login view harus menggunakan dispatch queue main async!!!
        DispatchQueue.main.async {
          let vc = LoginViewController()
          let nav = UINavigationController(rootViewController: vc)
          nav.modalPresentationStyle = .fullScreen
          self.present(nav, animated: true, completion: nil)
        }
      }
    }
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
  
  private func configureTabBar() {
    let home = templateTabBar(with: "Home", image: UIImage(named: "icon-home"), selectedImage: UIImage(named: "icon-home-active")?.withRenderingMode(.alwaysOriginal), viewController: HomeViewController())
    //      let explore = templateTabBar(with: "Explore", image: UIImage(named: "icon-search"), selectedImage: UIImage(named: "icon-search-active"), viewController: EmptyViewController())
    let favorite = templateTabBar(with: "Favorite", image: UIImage(named: "icon-favorite"), selectedImage: UIImage(named: "icon-favorite-active")?.withRenderingMode(.alwaysOriginal), viewController: FavoriteViewController())
    let ticket = templateTabBar(with: "Ticket", image: UIImage(named: "icon-ticket"), selectedImage: UIImage(named: "icon-ticket-active")?.withRenderingMode(.alwaysOriginal), viewController: TicketViewController())
    let profile = templateTabBar(with: "Profile", image: UIImage(named: "icon-people"), selectedImage: UIImage(named: "icon-people-active")?.withRenderingMode(.alwaysOriginal), viewController: ProfileViewController())
    
    setViewControllers([home, favorite, ticket, profile], animated: false)
  }
  
  private func templateTabBar(with title: String, image: UIImage?, selectedImage: UIImage?, viewController: UIViewController) -> UINavigationController {
    let nav = UINavigationController(rootViewController: viewController)
    
    nav.tabBarItem.title = title
    nav.tabBarItem.image = image
    nav.tabBarItem.selectedImage = selectedImage
    
    //    nav.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    return nav
  }
  
}
