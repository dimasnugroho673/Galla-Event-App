//
//  TicketViewController.swift
//  Galla
//
//  Created by Dimas Putro on 29/06/22.
//

import UIKit

class TicketViewController: UIViewController {

  private let ticketViewModel: TicketViewModel = TicketViewModel(ticketService: Injection().provideTicket())

  lazy var ticketTableView: UITableView = {
    let tv = UITableView()
    tv.translatesAutoresizingMaskIntoConstraints = false

    tv.backgroundColor = UIColor(named: "color-backround")
//    tv.register(UITableViewCell.self, forCellReuseIdentifier: "TicketCell")
    tv.register(TickerTableViewCell.self, forCellReuseIdentifier: TickerTableViewCell.identifier)
    tv.delegate = self
    tv.dataSource = self

    return tv
  }()

  lazy var navBarView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.heightAnchor.constraint(equalToConstant: 91).isActive = true
    view.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true

    return view
  }()

  lazy var titleNavBar: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Tickets"
    label.textColor = UIColor(named: "color-black")
    label.font = UIFont(name: "Poppins-SemiBold", size: 14)

    return label
  }()

  lazy var leftButtonNavBar: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "chevron.left")?.withTintColor(UIColor(named: "color-black")!, renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration.init(weight: UIImage.SymbolWeight.semibold)), for: .normal)
    button.heightAnchor.constraint(equalToConstant: 22).isActive = true
    button.widthAnchor.constraint(equalToConstant: 22).isActive = true

//    button.addTarget(self, action: #selector(handleBackButtonNav), for: .touchUpInside)

//    button.isHidden = true

    return button
  }()

  lazy var notifButtonNavBar: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "bell")?.withTintColor(UIColor(named: "color-black")!, renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration.init(weight: UIImage.SymbolWeight.semibold)), for: .normal)
    button.heightAnchor.constraint(equalToConstant: 22).isActive = true
    button.widthAnchor.constraint(equalToConstant: 22).isActive = true

    return button
  }()

//  lazy var ticketView: TicketView = TicketView()

  override func viewDidLoad() {
    super.viewDidLoad()

    configureUI()
    configureBinding()

    ticketViewModel.getAll(isCanceled: false)
  }

  private func configureUI() {
    view.backgroundColor = UIColor(named: "color-background")

//    view.addSubview(scrollView)
//    scrollView.addSubview(containerView)
    view.addSubview(navBarView)
    view.addSubview(ticketTableView)
//    containerView.addSubview(ticketView)

    let navBarStack = UIStackView(arrangedSubviews: [leftButtonNavBar, titleNavBar, notifButtonNavBar])
    navBarStack.translatesAutoresizingMaskIntoConstraints = false
    navBarStack.axis = .horizontal
    navBarStack.alignment = .center
    navBarStack.distribution = .equalSpacing

//    navBarView.addSubview(navBarStack)

    NSLayoutConstraint.activate([
      navBarView.topAnchor.constraint(equalTo: view.topAnchor),
      navBarView.leftAnchor.constraint(equalTo: view.leftAnchor),
      navBarView.rightAnchor.constraint(equalTo: view.rightAnchor),

//      navBarStack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5),
//      navBarStack.leftAnchor.constraint(equalTo: navBarView.leftAnchor, constant: 15),
//      navBarStack.rightAnchor.constraint(equalTo: navBarView.rightAnchor, constant: -15),

//      scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
//      scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
//      scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
//
//      containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
//      containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
//      containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0),
//      containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0),
//      containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//
//      ticketView.topAnchor.constraint(equalTo: containerView.topAnchor),
//      ticketView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
//      ticketView.rightAnchor.constraint(equalTo: containerView.rightAnchor),

      ticketTableView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
      ticketTableView.heightAnchor.constraint(equalToConstant: self.view.frame.height),
      ticketTableView.topAnchor.constraint(equalTo: navBarView.bottomAnchor),
      ticketTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      ticketTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
      ticketTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  private func configureBinding() {
    ticketViewModel.tickets.bind { _ in
      self.ticketTableView.reloadData()
    }
  }
}

extension TicketViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 550
//    return UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    return print("DEBUG: Ticket selected: \(indexPath.row)")
  }
}

extension TicketViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ticketViewModel.tickets.value.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = ticketTableView.dequeueReusableCell(withIdentifier: TickerTableViewCell.identifier, for: indexPath) as! TickerTableViewCell
    cell.width = self.view.frame.width

//    cell.textLabel?.text = ticketViewModel.tickets.value[indexPath.row].name
//    cell.addSubview(ticketView)
    cell.label.text = ticketViewModel.tickets.value[indexPath.row].name

    return cell
  }


}
