import XCTest
import CompoundFileReader
@testable import OfficeFileReader

final class DumpFileTests: XCTestCase {
    static func dump(file: DocFile) -> String {
        var s = ""
        
        s += "NYI"

        return s
    }
    
    func testDumpDoc() throws {
        for (name, fileExtension) in [
            ("decalage2/olefile/test-ole-file", "doc"),
            ("hughbe/Hello World", "doc"),
            ("hughbe/sample", "doc"),
            ("hughbe/sample2", "doc"),
            ("hughbe/file-sample_100kB", "doc"),
            ("hughbe/file-sample_500kB", "doc"),
            ("ironfede/openmcdf/english.presets", "doc"),
            ("ironfede/openmcdf/mediationform", "doc"),
            ("ironfede/openmcdf/poWEr.prelim", "doc"),
            ("ironfede/openmcdf/wstr_presets", "doc"),
            ("pehohlva/wv2qt/testole", "doc"),
        ] {
            let data = try getData(name: name, fileExtension: fileExtension)
            let file = try DocFile(data: data)
            print(DumpFileTests.dump(file: file))
        }
    }
    
    func testDumpPpt() throws {
        for (name, fileExtension) in [
            /*
            ("castello/javajungsuk3/1", "ppt"),
            ("castello/javajungsuk3/2", "ppt"),
            ("castello/javajungsuk3/3", "ppt"),
            ("castello/javajungsuk3/4", "ppt"),
            ("castello/javajungsuk3/5", "ppt"),
            ("castello/javajungsuk3/6", "ppt"),
            ("castello/javajungsuk3/7", "ppt"),
            ("castello/javajungsuk3/8", "ppt"),
            ("castello/javajungsuk3/9", "ppt"),
            ("castello/javajungsuk3/10", "ppt"),
            ("castello/javajungsuk3/11", "ppt"),
            ("castello/javajungsuk3/12", "ppt"),
            ("castello/javajungsuk3/13", "ppt"),
            ("castello/javajungsuk3/14", "ppt"),
            ("castello/javajungsuk3/15", "ppt"),
            ("castello/javajungsuk3/16", "ppt"),
            ("castello/javajungsuk3/17", "ppt"),
            ("castello/javajungsuk3/18", "ppt"),
            ("castello/javajungsuk3/19", "ppt"),
            ("castello/javajungsuk3/20", "ppt"),
            ("hughbe/Hello World", "ppt"),
            ("ironfede/openmcdf/_Test", "ppt"),
            ("ironfede/openmcdf/2_MB-W", "ppt"),
            ("online/file-examples.com/file_example_PPT_1MB", "ppt"),
            ("online/file-examples.com/file_example_PPT_250kB", "ppt"),
            ("online/file-examples.com/file_example_PPT_500kB", "ppt"),
            */
            ("online/file.fyicenter.com/sample", "ppt"),
            ("online/exp2003_ppt_ppt_02", "ppt"),
            ("online/ffc", "ppt"),
            ("online/PowerPointSequenceOptions", "ppt"),
            ("online/pptexamples", "ppt"),
            ("online/Presentations-Tips", "ppt"),
            ("online/sample", "ppt"),
            ("online/SamplePPTFile_500kb", "ppt"),
            ("online/SamplePPTFile_1000kb", "ppt"),
            ("PHPOffice/PHPPresentation/Sample_00_01", "ppt"),
            ("PHPOffice/PHPPresentation/Sample_00_02", "ppt"),
            ("PHPOffice/PHPPresentation/Sample_00_03", "ppt"),
            ("PHPOffice/PHPPresentation/Sample_00_04", "ppt"),
            ("SheetJS/test_files_pres/layout_types_2011", "ppt"),
        ] {
            let data = try getData(name: name, fileExtension: fileExtension)
            let file = try PptFile(data: data)
            XCTAssertNotNil(file.powerPointDocumentStream)
        }
    }

    static var allTests = [
        ("testDumpDoc", testDumpDoc),
        ("testDumpPpt", testDumpPpt),
    ]
}
