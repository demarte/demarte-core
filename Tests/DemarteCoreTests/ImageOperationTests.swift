//
//  NetworkingTests.swift
//  DemarteCoreTests
//
//  Created by Ivan De Martino on 12/5/20.
//

import XCTest
@testable import DemarteCore

class ImageOperationTests: XCTestCase {

  func testFetchImageSuccess() {
    let expectation = XCTestExpectation(description: "Called for image")
    guard let url = URL(string: "https://image.tmdb.org/t/p/w200/aCw8ONfyz3AhngVQa1E2Ss4KSUQ.jpg") else {
      return XCTFail("Could not create URL")
    }
    DemarteCore.fetchImage(from: url) { result in
      expectation.fulfill()
      switch result {
      case .success(let image):
        XCTAssertNotNil(image)
      case .failure:
        XCTFail("Expected success")
      }
    }
    wait(for: [expectation], timeout: 5)
  }

  func testFetchImageBadRequest() {
    let url = URL(string: "https://image.tmdb.org/t/p/2000/aCw8ONfyz3AhngVQa1E2Ss4KSUQ.jpg")!
    let expectation = XCTestExpectation(description: "Called for image")
    DemarteCore.fetchImage(from: url) { result in
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
    ("testFetchImageSuccess", testFetchImageSuccess),
    ("testFetchImageBadRequest", testFetchImageBadRequest)
  ]
}
