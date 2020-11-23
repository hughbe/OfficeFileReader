import XCTest
import DataStream
import CompoundFileReader
@testable import OfficeFileReader

final class PptFileTests: XCTestCase {
    func testExample() throws {
        do {
            let data = try getData(name: "hughbe/Hello World", fileExtension: "ppt")
            let file = try PptFile(data: data)
            XCTAssertNotNil(file.currentUser)
            XCTAssertNotNil(file.pictures)
            XCTAssertNotNil(file.powerPointDocumentStream)
        }
        do {
            let data = try getData(name: "ironfede/openmcdf/_Test", fileExtension: "ppt")
            let file = try PptFile(data: data)
            XCTAssertNotNil(file.currentUser)
            XCTAssertNil(file.pictures)
            XCTAssertNotNil(file.powerPointDocumentStream)
        }
        do {
            let data = try getData(name: "ironfede/openmcdf/2_MB-W", fileExtension: "ppt")
            let file = try PptFile(data: data)
            XCTAssertNotNil(file.currentUser)
            XCTAssertNotNil(file.pictures)
            XCTAssertNotNil(file.powerPointDocumentStream)
        }
        do {
            let data = try getData(name: "online/file-examples.com/file_example_PPT_1MB", fileExtension: "ppt")
            let file = try PptFile(data: data)
            XCTAssertNotNil(file.currentUser)
            XCTAssertNotNil(file.pictures)
            XCTAssertNotNil(file.powerPointDocumentStream)
        }
        do {
            let data = try getData(name: "online/file-examples.com/file_example_PPT_250kB", fileExtension: "ppt")
            let file = try PptFile(data: data)
            XCTAssertNotNil(file.currentUser)
            XCTAssertNotNil(file.pictures)
            XCTAssertNotNil(file.powerPointDocumentStream)
        }
        do {
            let data = try getData(name: "online/file-examples.com/file_example_PPT_500kB", fileExtension: "ppt")
            let file = try PptFile(data: data)
            XCTAssertNotNil(file.currentUser)
            XCTAssertNotNil(file.pictures)
            XCTAssertNotNil(file.powerPointDocumentStream)
        }
        do {
            let data = try getData(name: "SheetJS/test_files_pres/layout_types_2011", fileExtension: "ppt")
            let file = try PptFile(data: data)
            XCTAssertNotNil(file.currentUser)
            XCTAssertNotNil(file.pictures)
            XCTAssertNotNil(file.powerPointDocumentStream)
        }
    }
    
    static var allTests = [
        ("testExample", testExample),
    ]
}
