import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(ImageOperationTests.allTests),
    testCase(MediaOperationTests.allTests)
  ]
}
#endif
