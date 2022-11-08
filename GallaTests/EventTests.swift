//
//  EventTests.swift
//  EventTests
//
//  Created by Dimas Putro on 26/06/22.
//

import XCTest
@testable import Galla

class EventTests: XCTestCase {

  func testExample() throws {
    let userData = User(uid: "732yb7rew8bf78wbfgwa", name: "Dimas", email: "dimasnugroho673@gmail.com", joined: "7 days ago", eventJoined: 3, eventCanceled: 0)
    var newUserData: User?

    let localDataSource = UserLocalDataSource()

    localDataSource.saveUserData(userData)
    newUserData = localDataSource.getUserData()

    XCTAssertEqual(newUserData?.uid, userData.uid)
    XCTAssertEqual(newUserData?.name, userData.name)
    XCTAssertEqual(newUserData?.email, userData.email)
    XCTAssertEqual(newUserData?.joined, userData.joined)
    XCTAssertEqual(newUserData?.eventJoined, userData.eventJoined)
    XCTAssertEqual(newUserData?.eventCanceled, userData.eventCanceled)
  }

  func eventNil() {
    
  }

}
