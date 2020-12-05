import XCTest
@testable import DemarteCore

final class DemarteCoreTests: XCTestCase {

  func testColorRedEqual() {
    let color = DemarteCore.colorFromHexString("FF0000")
    XCTAssertEqual(color, .red)
  }

    static var allTests = [
        ("testColorRedEqual", testColorRedEqual),
    ]
}
