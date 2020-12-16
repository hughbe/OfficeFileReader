import XCTest

import OfficeFileReaderTests

var tests = [XCTestCaseEntry]()
tests += DocFileTests.allTests()
tests += DumpFileTests.allTests()
tests += PptFileTests.allTests()
XCTMain(tests)
