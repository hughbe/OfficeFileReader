import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DocFileTests.allTests),
        testCase(DumpFileTests.allTests),
        testCase(PptFileTests.allTests),
    ]
}
#endif
