//
//  MediaOperationTests.swift
//  DemarteCore
//
//  Created by Ivan De Martino on 12/8/20.
//

import Foundation

import XCTest
@testable import DemarteCore

class MediaOperationTests: XCTestCase {

  func testFetchDataSuccess() {
    let expectation = XCTestExpectation(description: "Called for fetch data")
    guard let url = URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/Music/v4/29/6c/73/296c7359-20a2-daa4-b726-8ba2f3b49af3/mzaf_745247285689875746.plus.aac.p.m4a") else {
      return XCTFail("Could not create URL")
    }
    DemarteCore.fetchMedia(from: url) { result in
      expectation.fulfill()
      switch result {
      case .success(let data):
        XCTAssertNotNil(data)
      case .failure:
        XCTFail("Expected success")
      }
    }
    wait(for: [expectation], timeout: 5)
  }

  func testFetchDataBadRequest() {
    let url = URL(string: "https://www")!
    let expectation = XCTestExpectation(description: "Called for fetch data")
    DemarteCore.fetchMedia(from: url) { result in
      expectation.fulfill()
      switch result {
      case .success:
        XCTFail("Expected fail")
      case .failure(let error):
        XCTAssertEqual(error, .badRequest)
      }
    }
    wait(for: [expectation], timeout: 5)
  }

  static var allTests = [
    ("testFetchDataSuccess", testFetchDataSuccess),
    ("testFetchDataBadRequest", testFetchDataBadRequest)
  ]
}
