import XCTest
@testable import DemarteCore

final class ColorTests: XCTestCase {
  
  func testColorRedEqual() {
    let color = DemarteCore.Color.fromHexString("FF0000")
    XCTAssertEqual(color, .red)
  }

  func testDemarteColorsAreEqual() {
    let color = DemarteCore.Color.fromHexString("006736")
    XCTAssertEqual(color, DemarteCore.Color.primary)
  }
  
  static var allTests = [
    ("testColorRedEqual", testColorRedEqual,
     "testDemarteColorsAreEqual", testDemarteColorsAreEqual),
  ]
}
