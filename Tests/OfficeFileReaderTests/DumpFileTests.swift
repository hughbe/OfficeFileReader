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
            //("nolze/msoffcrypto-tool/plain", "ppt"),
            //("nolze/msoffcrypto-tool/rc4cryptoapi_password", "ppt"),
            ("online/bz.apache.org/5 Tips for Networking %26 Speaking", "ppt"),
            ("online/bz.apache.org/18-28-IsraelEarthquake", "ppt"),
            ("online/bz.apache.org/2003", "ppt"),
            ("online/bz.apache.org/95415", "ppt"),
            ("online/bz.apache.org/a", "ppt"),
            ("online/bz.apache.org/Alignment", "ppt"),
            ("online/bz.apache.org/Apoios", "ppt"),
            ("online/bz.apache.org/animate", "ppt"),
            ("online/bz.apache.org/b", "ppt"),
            ("online/bz.apache.org/Bad2", "ppt"),
            ("online/bz.apache.org/bugdoc_2", "ppt"),
            ("online/bz.apache.org/graphic-hangs", "ppt"),
            ("online/bz.apache.org/Facebook", "ppt"),
            ("online/bz.apache.org/from1", "ppt"),
            ("online/bz.apache.org/from2", "ppt"),
            ("online/bz.apache.org/JMSS2010Eng10_Wk9_L1_MacbethA1Sc1_powerpoint", "ppt"),
            ("online/bz.apache.org/MSO-PP-2003-MouseClick", "ppt"),
            ("online/bz.apache.org/MSO-PP-2003-MouseOver", "ppt"),
            ("online/bz.apache.org/MSO-PP-2003", "ppt"),
            ("online/bz.apache.org/paste", "ppt"),
            ("online/bz.apache.org/PoimerTest1", "ppt"),
            ("online/bz.apache.org/PPT_GRCHART0010", "ppt"),
            ("online/bz.apache.org/Presentation2", "ppt"),
            ("online/bz.apache.org/test2", "ppt"),
            ("online/bz.apache.org/The Team Approach Members", "ppt"),
            ("online/file-examples.com/file_example_PPT_1MB", "ppt"),
            ("online/file-examples.com/file_example_PPT_250kB", "ppt"),
            ("online/file-examples.com/file_example_PPT_500kB", "ppt"),
            ("online/file.fyicenter.com/sample", "ppt"),
            ("online/pda.pcusa.org/1_pw_dp_disaster_101_(ppt)_-5", "ppt"),
            ("online/pda.pcusa.org/3_pw_dp_disaster_preparedness-2", "ppt"),
            ("online/pda.pcusa.org/preparedness_1-hour", "ppt"),
            ("online/pda.pcusa.org/preparedness_3-hour", "ppt"),
            ("online/pda.pcusa.org/pw_dp_photos_to_be_printed_for_tabletop", "ppt"),
            ("online/AQA-B-Psych-A2 online_Chapter 2_PowerPoint-presentation-2-1-revised-k-p", "ppt"),
            ("online/exp2003_ppt_ppt_02", "ppt"),
            ("online/ffc", "ppt"),
            ("online/PowerPointSequenceOptions", "ppt"),
            ("online/PPT SAMPLE FORMAT (1)", "ppt"),
            ("online/pptexamples", "ppt"),
            ("online/Presentations-Tips", "ppt"),
            ("online/PW LMD Lecture 2 (Examiners)", "ppt"),
            ("online/sample", "ppt"),
            ("online/SamplePPTFile_500kb", "ppt"),
            ("online/SamplePPTFile_1000kb", "ppt"),
            ("online/What_You_Will_Learn", "ppt"),
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
