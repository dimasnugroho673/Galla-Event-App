//
//  GallaTests.swift
//  GallaTests
//
//  Created by Dimas Putro on 26/06/22.
//

import XCTest
@testable import Galla

class GallaTests: XCTestCase {

  func testExample() throws {
    let userData = User(uid: "732yb7rew8bf78wbfgwa", name: "Dimas", email: "dimasnugroho673@gmail.com", joined: "7 days ago")

    let localDataSource = UserLocalDataSource()

    localDataSource.saveUserData(userData)
    localDataSource.getUserData { user in
      XCTAssertEqual(user.uid, userData.uid)
      XCTAssertEqual(user.name, userData.name)
      XCTAssertEqual(user.email, userData.email)
      XCTAssertEqual(user.joined, userData.joined)
    }
  }

}
