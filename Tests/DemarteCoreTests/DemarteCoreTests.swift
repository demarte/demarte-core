import XCTest
@testable import DemarteCore

final class DemarteCoreTests: XCTestCase {
  
  func testColorRedEqual() {
    let color = DemarteCore.colorFromHexString("FF0000")
    XCTAssertEqual(color, .red)
  }

  func testDemarteColorsAreEqual() {
    let color = DemarteCore.colorFromHexString("006736")
    XCTAssertEqual(color, DemarteCore.color)
  }
  
  static var allTests = [
    ("testColorRedEqual", testColorRedEqual),
  ]
}
