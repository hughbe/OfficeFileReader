import XCTest
import DataStream
import CompoundFileReader
import DataCompression
@testable import OfficeFileReader

final class PptFileTests: XCTestCase {
    func testExample() throws {
        /* hughbe */
        do {
            let data = try getData(name: "Hello World", fileExtension: "ppt")
            let file = try PptFile(data: data)
            XCTAssertNotNil(file.currentUser)
            XCTAssertNotNil(file.pictures)
            XCTAssertNotNil(file.powerPointDocumentStream)
        }
        /* ironfede/openmcdf */
        do {
            /* ironfede/openmcdf */
            let data = try getData(name: "_Test", fileExtension: "ppt")
            let file = try PptFile(data: data)
            XCTAssertNotNil(file.currentUser)
            XCTAssertNil(file.pictures)
            XCTAssertNotNil(file.powerPointDocumentStream)
        }
        do {
            /* ironfede/openmcdf */
            let data = try getData(name: "2_MB-W", fileExtension: "ppt")
            let file = try PptFile(data: data)
            XCTAssertNotNil(file.currentUser)
            XCTAssertNotNil(file.pictures)
            XCTAssertNotNil(file.powerPointDocumentStream)
        }
        do {
            /* online/file-examples.com */
            let data = try getData(name: "file_example_PPT_1MB", fileExtension: "ppt")
            let file = try PptFile(data: data)
            XCTAssertNotNil(file.currentUser)
            XCTAssertNotNil(file.pictures)
            XCTAssertNotNil(file.powerPointDocumentStream)
        }
        do {
            /* online/file-examples.com */
            let data = try getData(name: "file_example_PPT_250kB", fileExtension: "ppt")
            let file = try PptFile(data: data)
            XCTAssertNotNil(file.currentUser)
            XCTAssertNotNil(file.pictures)
            XCTAssertNotNil(file.powerPointDocumentStream)
        }
        do {
            /* online/file-examples.com */
            let data = try getData(name: "file_example_PPT_500kB", fileExtension: "ppt")
            let file = try PptFile(data: data)
            XCTAssertNotNil(file.currentUser)
            XCTAssertNotNil(file.pictures)
            XCTAssertNotNil(file.powerPointDocumentStream)
        }
        do {
            /* SheetJS/test_files_pres */
            let data = try getData(name: "layout_types_2011", fileExtension: "ppt")
            let file = try PptFile(data: data)
            XCTAssertNotNil(file.currentUser)
            XCTAssertNotNil(file.pictures)
            XCTAssertNotNil(file.powerPointDocumentStream)
        }
    }

    func testVBAProject() throws {
        /* hughbe */
        do {
            let data = try getData(name: "VBA Project", fileExtension: "pps")
            let file = try PptFile(data: data)
            XCTAssertNotNil(file.powerPointDocumentStream)
        }
        do {
            let data = try getData(name: "VBA Project", fileExtension: "ppt")
            let file = try PptFile(data: data)
            XCTAssertNotNil(file.powerPointDocumentStream.vbaProject)
            guard case let .compressed(data: vbaData) = file.powerPointDocumentStream.vbaProject else {
                XCTAssertFalse(true)
                return
            }
            
            let deflatedData = Data(vbaData.pptVbaProjStgCompressed).deflate()!
            XCTAssertNotNil(deflatedData)
            //var deflatedDataStream = DataStream(deflatedData)
            // let cfb = try CompoundFile(dataStream: &dataStream)
        }
    }
    
    static var allTests = [
        ("testExample", testExample),
        ("testVBAProject", testVBAProject),
    ]
}
