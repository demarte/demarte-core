import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(ColorTests.allTests),
    testCase(NetworkingTests.allTests)
  ]
}
#endif
