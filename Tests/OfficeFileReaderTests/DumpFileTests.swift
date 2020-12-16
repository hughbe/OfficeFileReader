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
            /* decalage2/olefile */
            ("test-ole-file", "doc"),
            
            /* hughbe */
            ("Hello World", "doc"),
            ("sample", "doc"),
            ("sample2", "doc"),
            ("file-sample_100kB", "doc"),
            ("file-sample_500kB", "doc"),
            
            /* ironfede/openmcdf/ */
            ("english.presets", "doc"),
            ("mediationform", "doc"),
            ("poWEr.prelim", "doc"),
            ("wstr_presets", "doc"),
            
            /* pehohlva/wv2qt */
            ("testole", "doc"),
        ] {
            let data = try getData(name: name, fileExtension: fileExtension)
            let file = try DocFile(data: data)
            print(DumpFileTests.dump(file: file))
        }
    }
    
    func testDumpPpt() throws {
        for (name, fileExtension) in [
            /* castello/javajungsuk3 */
            ("1", "ppt"),
            ("2", "ppt"),
            ("3", "ppt"),
            ("4", "ppt"),
            ("5", "ppt"),
            ("6", "ppt"),
            ("7", "ppt"),
            ("8", "ppt"),
            ("9", "ppt"),
            ("10", "ppt"),
            ("11", "ppt"),
            ("12", "ppt"),
            ("13", "ppt"),
            ("14", "ppt"),
            ("15", "ppt"),
            ("16", "ppt"),
            ("17", "ppt"),
            ("18", "ppt"),
            ("19", "ppt"),
            ("20", "ppt"),
            
            /* hughbe */
            ("Hello World", "ppt"),
            
            /* ironfede/openmcdf/ */
            ("_Test", "ppt"),
            ("2_MB-W", "ppt"),
            
            /* nolze/msoffcrypto-tool */
            //("plain", "ppt"),
            //("rc4cryptoapi_password", "ppt"),
            
            /* https://bz.apache.org */
            ("5 Tips for Networking Speaking", "ppt"),
            ("18-28-IsraelEarthquake", "ppt"),
            ("2003", "ppt"),
            ("95415", "ppt"),
            ("a", "ppt"),
            ("Alignment", "ppt"),
            ("Apoios", "ppt"),
            ("animate", "ppt"),
            ("b", "ppt"),
            ("Bad2", "ppt"),
            ("bugdoc_2", "ppt"),
            ("graphic-hangs", "ppt"),
            ("Facebook", "ppt"),
            ("from1", "ppt"),
            ("from2", "ppt"),
            ("JMSS2010Eng10_Wk9_L1_MacbethA1Sc1_powerpoint", "ppt"),
            ("MSO-PP-2003-MouseClick", "ppt"),
            ("MSO-PP-2003-MouseOver", "ppt"),
            ("MSO-PP-2003", "ppt"),
            ("paste", "ppt"),
            ("PoimerTest1", "ppt"),
            ("PPT_GRCHART0010", "ppt"),
            ("Presentation2", "ppt"),
            ("test2", "ppt"),
            ("The Team Approach Members", "ppt"),
            
            /* https://file-examples.com */
            ("file_example_PPT_1MB", "ppt"),
            ("file_example_PPT_250kB", "ppt"),
            ("file_example_PPT_500kB", "ppt"),
            
            /* https://file.fyicenter.com */
            ("sample", "ppt"),
            
            /* pda.pcusa.org */
            ("1_pw_dp_disaster_101_(ppt)_-5", "ppt"),
            ("3_pw_dp_disaster_preparedness-2", "ppt"),
            ("preparedness_1-hour", "ppt"),
            ("preparedness_3-hour", "ppt"),
            ("pw_dp_photos_to_be_printed_for_tabletop", "ppt"),
            
            /* online */
            ("AQA-B-Psych-A2 online_Chapter 2_PowerPoint-presentation-2-1-revised-k-p", "ppt"),
            ("exp2003_ppt_ppt_02", "ppt"),
            ("ffc", "ppt"),
            ("PowerPointSequenceOptions", "ppt"),
            ("PPT SAMPLE FORMAT (1)", "ppt"),
            ("pptexamples", "ppt"),
            ("Presentations-Tips", "ppt"),
            ("PW LMD Lecture 2 (Examiners)", "ppt"),
            ("online_sample", "ppt"),
            ("SamplePPTFile_500kb", "ppt"),
            ("SamplePPTFile_1000kb", "ppt"),
            ("What_You_Will_Learn", "ppt"),
            
            /* PHPOffice/PHPPresentation*/
            ("Sample_00_01", "ppt"),
            ("Sample_00_02", "ppt"),
            ("Sample_00_03", "ppt"),
            ("Sample_00_04", "ppt"),
            
            /* SheetJS/test_files_pres */
            ("layout_types_2011", "ppt"),
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
