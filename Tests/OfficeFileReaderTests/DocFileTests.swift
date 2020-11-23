import XCTest
import DataStream
import CompoundFileReader
@testable import OfficeFileReader

final class DocFileTests: XCTestCase {
    func testExample() throws {
        do {
            let data = try getData(name: "hughbe/Hello World", fileExtension: "doc")
            let file = try DocFile(data: data)

            XCTAssertEqual("Hello World\rWhat is up\r", try file.getText(at: 0)!)
            XCTAssertEqual("ello World\rWhat is up\r", try file.getText(at: 1)!)
            XCTAssertEqual("\r", try file.getText(at: 22)!)
            XCTAssertNil(try file.getText(at: 23))
            
            do {
                let (start, end) = try file.getParagraphBoundaries(containing: 0)!
                XCTAssertEqual(0, start)
                XCTAssertEqual(11, end)
            }
            do {
                let (start, end) = try file.getParagraphBoundaries(containing: 1)!
                XCTAssertEqual(0, start)
                XCTAssertEqual(11, end)
            }
            do {
                let (start, end) = try file.getParagraphBoundaries(containing: 11)!
                XCTAssertEqual(0, start)
                XCTAssertEqual(11, end)
            }
            
            do {
                let (start, end) = try file.getParagraphBoundaries(containing: 12)!
                XCTAssertEqual(12, start)
                XCTAssertEqual(22, end)
            }
            do {
                let (start, end) = try file.getParagraphBoundaries(containing: 20)!
                XCTAssertEqual(12, start)
                XCTAssertEqual(22, end)
            }
            do {
                let (start, end) = try file.getParagraphBoundaries(containing: 22)!
                XCTAssertEqual(12, start)
                XCTAssertEqual(22, end)
            }
            do {
                XCTAssertNil(try file.getParagraphBoundaries(containing: 23))
            }
            
            XCTAssertNotNil(file.wordDocumentStream.fib)
            XCTAssertNotNil(file.dop)
            XCTAssertNotNil(file.stshf)
            XCTAssertNil(file.plcffndRef)
            XCTAssertNil(file.plcffndTxt)
            XCTAssertNil(file.plcfandRef)
            XCTAssertNil(file.plcfandTxt)
            XCTAssertNotNil(file.plcfSed)
            
            for sed in file.plcfSed!.aSed {
                var dataStream = file.wordDocumentStream.dataStream
                dataStream.position = Int(sed.fcSepx)
                
                let sepx = try Sepx(dataStream: &dataStream)
                XCTAssertEqual(44, sepx.cb)
                XCTAssertEqual(11, sepx.grpprl.count)
            }
        
            XCTAssertNil(file.sttbfGlsy)
            XCTAssertNil(file.plcfGlsy)
            XCTAssertNil(file.plcfhdd)
            XCTAssertNotNil(file.plcfBteChpx)
            XCTAssertNotNil(file.plcfBtePapx)
            XCTAssertNotNil(file.sttbfFfn)
            XCTAssertEqual(["Times New Roman", "Symbol", "Arial", "Calibri", "Calibri Light", "Cambria Math"], file.sttbfFfn?.sttb.data.map { $0.xszFfn })
            XCTAssertNil(file.plcfFldMom)
            XCTAssertNil(file.plcfFldHdr)
            XCTAssertNil(file.plcfFldFtn)
            XCTAssertNil(file.plcfFldAtn)
            XCTAssertNil(file.sttbfBkmk)
            XCTAssertNil(file.plcfBkf)
            XCTAssertNil(file.plcfBkl)
            XCTAssertNotNil(file.cmds)
            XCTAssertEqual(0, file.cmds!.tcg.rgtcgData.count)
            XCTAssertNil(file.prDrvr)
            XCTAssertNil(file.prEnvPort)
            XCTAssertNil(file.prEnvLand)
            XCTAssertNotNil(file.wss)
            XCTAssertEqual(["", "", "", "", "", "", "Hugh Bellamy", "Hugh Bellamy", "", "", "", "", "", "", "", "", "", ""], file.sttbfAssoc!.sttb.data)
            XCTAssertNotNil(file.clx)
            XCTAssertNil(file.grpXstAtnOwners)
            XCTAssertNil(file.sttbfAtnBkmk)
            XCTAssertNil(file.plcSpaMom)
            XCTAssertNil(file.plcSpaHdr)
            XCTAssertNil(file.plcfAtnBkf)
            XCTAssertNil(file.plcfAtnBkl)
            XCTAssertNil(file.pms)
            XCTAssertNil(file.plcfendRef)
            XCTAssertNil(file.plcfendTxt)
            XCTAssertNil(file.plcfFldEdn)
            XCTAssertNotNil(file.dggInfo)
            XCTAssertNotNil(file.sttbfRMark)
            XCTAssertEqual(["Unknown"], file.sttbfRMark!.sttb.data)
            XCTAssertNil(file.sttbfCaption)
            XCTAssertNil(file.sttbfAutoCaption)
            XCTAssertNil(file.plcfWkb)
            XCTAssertNotNil(file.plcfSpl)
            XCTAssertEqual(1, file.plcfSpl!.aSpellingSpls.count)
            XCTAssertNil(file.plcftxbxTxt)
            XCTAssertNil(file.plcfFldTxbx)
            XCTAssertNil(file.plcfHdrtxbxTxt)
            XCTAssertNil(file.plcffldHdrTxbx)
            XCTAssertNil(file.stwUser)
            XCTAssertNil(file.sttbTtmbd)
            XCTAssertNil(file.cookieData)
            XCTAssertNil(file.routeSlip)
            XCTAssertNil(file.sttbSavedBy)
            XCTAssertNil(file.sttbFnm)
            XCTAssertNil(file.plfLst)
            XCTAssertNil(file.plfLfo)
            XCTAssertNil(file.plcfTxbxBkd)
            XCTAssertNil(file.plcfTxbxHdrBkd)
            XCTAssertNil(file.sttbGlsyStyle)
            XCTAssertNil(file.plgosl)
            XCTAssertNil(file.plcocx)
            XCTAssertNil(file.plcfAsumy)
            XCTAssertNil(file.sttbListNames)
            XCTAssertNotNil(file.plcfTch)
            XCTAssertEqual(2, file.plcfTch!.aData.count)
            XCTAssertNotNil(file.rmdThreading)
            XCTAssertEqual([""], file.rmdThreading!.sttbMessage.data)
            XCTAssertEqual([""], file.rmdThreading!.sttbStyle.data)
            XCTAssertEqual(0, file.rmdThreading!.sttbAuthorAttrib.data.count)
            XCTAssertEqual(0, file.rmdThreading!.sttbAuthorValue.data.count)
            XCTAssertEqual(0, file.rmdThreading!.sttbMessageAttrib.data.count)
            XCTAssertEqual(0, file.rmdThreading!.sttbMessageValue.data.count)
            XCTAssertNil(file.sttbRgtplc)
            XCTAssertNil(file.msoEnvelope)
            XCTAssertNotNil(file.plcfLad)
            XCTAssertEqual(2, file.plcfLad!.aData.count)
            XCTAssertNil(file.rgDofr)
            XCTAssertNil(file.plcosl)
            XCTAssertNil(file.plcfCookieOld)
            XCTAssertNil(file.plcfPgp)
            XCTAssertNil(file.plcfuim)
            XCTAssertNil(file.plfguidUim)
            XCTAssertNil(file.atrdExtra)
            XCTAssertNotNil(file.plrsid)
            XCTAssertEqual(4, file.plrsid!.rgrsid.count)
            XCTAssertNil(file.sttbfBkmkFactoid)
            XCTAssertNil(file.plcfBkfFactoid)
            XCTAssertNil(file.plcfcookie)
            XCTAssertNil(file.plcfBklFactoid)
            XCTAssertNil(file.factoidData)
            XCTAssertNil(file.sttbfBkmkFcc)
            XCTAssertNil(file.plcfBkfFcc)
            XCTAssertNil(file.sttbfbkmkBPRepairs)
            XCTAssertNil(file.plcfbkfBPRepairs)
            XCTAssertNil(file.plcfbklBPRepairs)
            XCTAssertNil(file.pmsNew)
            XCTAssertNil(file.odso)
            XCTAssertNotNil(file.plcffactoid)
            XCTAssertEqual(2, file.plcffactoid!.aData.count)
            XCTAssertNil(file.hplxsdr)
            XCTAssertNil(file.sttbfBkmkSdt)
            XCTAssertNil(file.plcfBkfSdt)
            XCTAssertNil(file.plcfBklSdt)
            XCTAssertNil(file.customXForm)
            XCTAssertNil(file.sttbfBkmkProt)
            XCTAssertNil(file.plcfBkfProt)
            XCTAssertNil(file.plcfBklProt)
            XCTAssertNil(file.sttbProtUser)
            XCTAssertNil(file.afd)
            
            print(try file.getParagraphFormatting(characterPosition: 1)!)
            print(try file.getCharacterFormatting(characterPosition: 1)!)
            print(try file.getStyleProperties(istd: 0)!)
            
            print(file.paragraphs!.map { $0.text })
        }
        do {
            let data = try getData(name: "hughbe/sample", fileExtension: "doc")
            let file = try DocFile(data: data)

            let text = try file.getText(at: 0)!
            print(text)
        }
        do {
            let data = try getData(name: "pehohlva/wv2qt/testole", fileExtension: "doc")
            let file = try DocFile(data: data)

            let text = try file.getText(at: 0)!
            print(text)
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
