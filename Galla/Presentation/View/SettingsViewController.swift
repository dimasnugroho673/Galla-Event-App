//
//  SettingsViewController.swift
//  Galla
//
//  Created by Dimas Putro on 24/08/22.
//

import UIKit

class SettingsViewController: UIViewController {

  let settingsViewModel: SettingsViewModel = SettingsViewModel(userUseCase: Injection().provideAuth())

  private lazy var navBarView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.heightAnchor.constraint(equalToConstant: 91).isActive = true
    view.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true

    return view
  }()

  private lazy var backButtonNavBar: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "chevron.left")?.withTintColor(UIColor(named: "color-black")!, renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration.init(weight: UIImage.SymbolWeight.semibold)), for: .normal)
    button.heightAnchor.constraint(equalToConstant: 22).isActive = true
    button.widthAnchor.constraint(equalToConstant: 22).isActive = true

    button.addTarget(self, action: #selector(handleBackButtonNav), for: .touchUpInside)

    return button
  }()

  private lazy var titleNavBar: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Settings"
    label.textColor = UIColor(named: "color-black")
    label.font = UIFont(name: "Poppins-SemiBold", size: 14)

    return label
  }()

  private lazy var settingsTableView: UITableView  = {
    let tv = UITableView()
    tv.translatesAutoresizingMaskIntoConstraints = false

    tv.backgroundColor = UIColor(named: "color-backround")
    tv.register(UITableViewCell.self, forCellReuseIdentifier: "SettingCell")
    tv.delegate = self
    tv.dataSource = self
    tv.separatorStyle = .none

    return tv
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    configureUI()
    configureBinding()
  }

  private func configureUI() {
    view.backgroundColor = UIColor(named: "color-background")

    view.addSubview(navBarView)
    navBarView.addSubview(titleNavBar)
    navBarView.addSubview(backButtonNavBar)
    view.addSubview(settingsTableView)

    NSLayoutConstraint.activate([
      navBarView.topAnchor.constraint(equalTo: view.topAnchor),
      navBarView.leftAnchor.constraint(equalTo: view.leftAnchor),
      navBarView.rightAnchor.constraint(equalTo: view.rightAnchor),

      titleNavBar.centerXAnchor.constraint(equalTo: navBarView.centerXAnchor),
      titleNavBar.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: -15),

      backButtonNavBar.rightAnchor.constraint(equalTo: navBarView.leftAnchor, constant: 30),
      backButtonNavBar.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: -15),

      settingsTableView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
      settingsTableView.heightAnchor.constraint(equalToConstant: self.view.frame.height),
      settingsTableView.topAnchor.constraint(equalTo: navBarView.bottomAnchor),
      settingsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      settingsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
      settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  private func configureBinding() {
    settingsViewModel.logoutStatus.bind { status in
      if status != nil && status == true {
        self.navigationController?.popViewController(animated: true)

        DispatchQueue.main.async {
          let vc = LoginViewController()
          let nav = UINavigationController(rootViewController: vc)
          nav.modalPresentationStyle = .fullScreen
          self.present(nav, animated: true, completion: nil)
        }
      }
    }
  }

  @objc func handleBackButtonNav() {
    navigationController?.popViewController(animated: true)
  }
}

extension SettingsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 10
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 40
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let data = settingsViewModel.settingsData[indexPath.section].data[indexPath.row]

    if data.identifier == "process.logout" {
      let actionSheet = UIAlertController(title: "Want to logout?", message: "We not save your account session", preferredStyle: .actionSheet)
      let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { _ in
        self.settingsViewModel.logout()
      }
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

      actionSheet.addAction(logoutAction)
      actionSheet.addAction(cancelAction)

      self.present(actionSheet, animated: true)
    }
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
    view.backgroundColor = UIColor(named: "color-background")

    let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 10))
    lbl.font = UIFont.systemFont(ofSize: 13)
    lbl.text = settingsViewModel.settingsData[section].sectionName
    view.addSubview(lbl)
    return view
  }
}

extension SettingsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    settingsViewModel.settingsData[section].sectionName.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = settingsTableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath)
    let data = settingsViewModel.settingsData[indexPath.section].data[indexPath.row]

    cell.textLabel?.text = data.title
    cell.textLabel?.font = UIFont(name: "Poppins-Regular", size: 14)

    if data.identifier == "process.logout" {
      cell.textLabel?.textColor = .systemRed
      cell.textLabel?.textAlignment = .center
    }

    return cell
  }


}
