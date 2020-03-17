import XCTest

import NativeKit_Test

var testCaseEntrySet: [XCTestCaseEntry] {
    var result = [XCTestCaseEntry]()
    result.append(contentsOf: NativeKit_Test.testCaseEntrySet)
    return result
}

XCTMain(testCaseEntrySet)
