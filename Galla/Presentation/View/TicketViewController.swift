//
//  TicketViewController.swift
//  Galla
//
//  Created by Dimas Putro on 29/06/22.
//

import UIKit

class CustomTapGestureRecognizer: UITapGestureRecognizer {
  var stringValue: String?
}

class TicketViewController: UIViewController {

  private let ticketViewModel: TicketViewModel = TicketViewModel(ticketService: Injection().provideTicket())

  var segmentActive: String = "Ongoing"

  lazy var ticketTableView: UITableView = {
    let tv = UITableView()
    tv.translatesAutoresizingMaskIntoConstraints = false

    tv.backgroundColor = UIColor(named: "color-backround")
    tv.register(TickerTableViewCell.self, forCellReuseIdentifier: TickerTableViewCell.identifier)
    tv.delegate = self
    tv.dataSource = self
    tv.separatorStyle = .none

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

  lazy var segmentedBarView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.heightAnchor.constraint(equalToConstant: 48).isActive = true
    view.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true

    view.backgroundColor = .white

    return view
  }()

  lazy var ongoingTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Ongoing"
    label.font = UIFont(name: "Poppins-SemiBold", size: 14)
    label.textColor = self.segmentActive == label.text ? UIColor(named: "color-primary") : .systemGray

    label.isUserInteractionEnabled = true
    let gesture = CustomTapGestureRecognizer(target: self, action: #selector(handleChangeSegment(sender:)))
    gesture.stringValue = "Ongoing"
    label.addGestureRecognizer(gesture)

    return label
  }()

  lazy var allTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "All"
    label.font = UIFont(name: "Poppins-SemiBold", size: 14)
    label.textColor = self.segmentActive == label.text ? UIColor(named: "color-primary") : .systemGray

    label.isUserInteractionEnabled = true
    let gesture = CustomTapGestureRecognizer(target: self, action: #selector(handleChangeSegment(sender:)))
    gesture.stringValue = "All"
    label.addGestureRecognizer(gesture)

    return label
  }()

  lazy var canceledTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Canceled"
    label.font = UIFont(name: "Poppins-SemiBold", size: 14)
    label.textColor = self.segmentActive == label.text ? UIColor(named: "color-primary") : .systemGray

    label.isUserInteractionEnabled = true
    let gesture = CustomTapGestureRecognizer(target: self, action: #selector(handleChangeSegment(sender:)))
    gesture.stringValue = "Canceled"
    label.addGestureRecognizer(gesture)

    return label
  }()

  lazy var activeSegmentIndicator: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.heightAnchor.constraint(equalToConstant: 3).isActive = true
    view.widthAnchor.constraint(equalToConstant: 84).isActive = true
    view.clipsToBounds = true
    view.layer.cornerRadius = 3 / 2
    view.backgroundColor = UIColor(named: "color-primary")

    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    configureUI()
    configureBinding()

    ticketViewModel.getAll(isCanceled: nil)
  }

  private func configureUI() {
    view.backgroundColor = UIColor(named: "color-background")

    view.addSubview(navBarView)
    view.addSubview(ticketTableView)

//    let navBarStack = UIStackView(arrangedSubviews: [leftButtonNavBar, titleNavBar, notifButtonNavBar])
//    navBarStack.translatesAutoresizingMaskIntoConstraints = false
//    navBarStack.axis = .horizontal
//    navBarStack.alignment = .center
//    navBarStack.distribution = .equalSpacing
//
//    navBarView.addSubview(navBarStack)

    navBarView.addSubview(titleNavBar)
    navBarView.addSubview(notifButtonNavBar)

    view.addSubview(segmentedBarView)

    let segmentedStack = UIStackView(arrangedSubviews: [ongoingTitleLabel, allTitleLabel, canceledTitleLabel])
    segmentedStack.translatesAutoresizingMaskIntoConstraints = false
    segmentedStack.axis = .horizontal
    segmentedStack.alignment = .center
    segmentedStack.distribution = .equalSpacing
    segmentedStack.spacing = 70

    segmentedBarView.addSubview(segmentedStack)
    segmentedBarView.addSubview(activeSegmentIndicator)

    NSLayoutConstraint.activate([
      navBarView.topAnchor.constraint(equalTo: view.topAnchor),
      navBarView.leftAnchor.constraint(equalTo: view.leftAnchor),
      navBarView.rightAnchor.constraint(equalTo: view.rightAnchor),

      segmentedBarView.topAnchor.constraint(equalTo: navBarView.bottomAnchor),
      segmentedBarView.leftAnchor.constraint(equalTo: view.leftAnchor),
      segmentedBarView.rightAnchor.constraint(equalTo: navBarView.rightAnchor),

      segmentedStack.centerYAnchor.constraint(equalTo: segmentedBarView.centerYAnchor),
      segmentedStack.centerXAnchor.constraint(equalTo: segmentedBarView.centerXAnchor),

      activeSegmentIndicator.bottomAnchor.constraint(equalTo: segmentedBarView.bottomAnchor),
      activeSegmentIndicator.leftAnchor.constraint(equalTo: segmentedBarView.leftAnchor, constant: 40),

//      navBarStack.leftAnchor.constraint(equalTo: navBarView.leftAnchor, constant: 15),
//      navBarStack.rightAnchor.constraint(equalTo: navBarView.rightAnchor, constant: -15),
//      navBarStack.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: -15),

      titleNavBar.centerXAnchor.constraint(equalTo: navBarView.centerXAnchor),
      titleNavBar.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: -15),

      notifButtonNavBar.rightAnchor.constraint(equalTo: navBarView.rightAnchor, constant: -15),
      notifButtonNavBar.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: -15),

      ticketTableView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
      ticketTableView.heightAnchor.constraint(equalToConstant: self.view.frame.height),
      ticketTableView.topAnchor.constraint(equalTo: segmentedBarView.bottomAnchor),
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

  @objc func handleChangeSegment(sender: CustomTapGestureRecognizer) {
    segmentActive = sender.stringValue!
    var xPosition: CGFloat = 0.0

    switch segmentActive {
    case "Ongoing":
      ongoingTitleLabel.textColor = UIColor(named: "color-primary")
      allTitleLabel.textColor = .systemGray
      canceledTitleLabel.textColor = .systemGray

      xPosition = ongoingTitleLabel.frame.origin.x + 40
    case "All":
      ongoingTitleLabel.textColor = .systemGray
      allTitleLabel.textColor = UIColor(named: "color-primary")
      canceledTitleLabel.textColor = .systemGray

      xPosition = allTitleLabel.frame.origin.x + 20
    case "Canceled":
      ongoingTitleLabel.textColor = .systemGray
      allTitleLabel.textColor = .systemGray
      canceledTitleLabel.textColor = UIColor(named: "color-primary")

      xPosition = canceledTitleLabel.frame.origin.x + 45
    default:
      return
    }

    UIView.animate(withDuration: 0.3) {
      self.activeSegmentIndicator.frame.origin.x = xPosition
    }

    ticketViewModel.filter(type: segmentActive)
  }
}

extension TicketViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 400
  }
}

extension TicketViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ticketViewModel.tickets.value.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = ticketTableView.dequeueReusableCell(withIdentifier: TickerTableViewCell.identifier, for: indexPath) as! TickerTableViewCell
    cell.width = self.view.frame.width
    cell.ticket = ticketViewModel.tickets.value[indexPath.row]

    return cell
  }


}
