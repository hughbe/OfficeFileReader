//
//  FibRgFcLcb2002.swift
//
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.5.8 FibRgFcLcb2002
/// The FibRgFcLcb2002 structure is a variable-sized portion of the Fib. It extends the FibRgFcLcb2000.
public struct FibRgFcLcb2002 {
    public let rgFcLcb2000: FibRgFcLcb2000
    public let fcUnused1: UInt32
    public let lcbUnused1: UInt32
    public let fcPlcfPgp: UInt32
    public let lcbPlcfPgp: UInt32
    public let fcPlcfuim: UInt32
    public let lcbPlcfuim: UInt32
    public let fcPlfguidUim: UInt32
    public let lcbPlfguidUim: UInt32
    public let fcAtrdExtra: UInt32
    public let lcbAtrdExtra: UInt32
    public let fcPlrsid: UInt32
    public let lcbPlrsid: UInt32
    public let fcSttbfBkmkFactoid: UInt32
    public let lcbSttbfBkmkFactoid: UInt32
    public let fcPlcfBkfFactoid: UInt32
    public let lcbPlcfBkfFactoid: UInt32
    public let fcPlcfcookie: UInt32
    public let lcbPlcfcookie: UInt32
    public let fcPlcfBklFactoid: UInt32
    public let lcbPlcfBklFactoid: UInt32
    public let fcFactoidData: UInt32
    public let lcbFactoidData: UInt32
    public let fcDocUndo: UInt32
    public let lcbDocUndo: UInt32
    public let fcSttbfBkmkFcc: UInt32
    public let lcbSttbfBkmkFcc: UInt32
    public let fcPlcfBkfFcc: UInt32
    public let lcbPlcfBkfFcc: UInt32
    public let fcPlcfBklFcc: UInt32
    public let lcbPlcfBklFcc: UInt32
    public let fcSttbfbkmkBPRepairs: UInt32
    public let lcbSttbfbkmkBPRepairs: UInt32
    public let fcPlcfbkfBPRepairs: UInt32
    public let lcbPlcfbkfBPRepairs: UInt32
    public let fcPlcfbklBPRepairs: UInt32
    public let lcbPlcfbklBPRepairs: UInt32
    public let fcPmsNew: UInt32
    public let lcbPmsNew: UInt32
    public let fcODSO: UInt32
    public let lcbODSO: UInt32
    public let fcPlcfpmiOldXP: UInt32
    public let lcbPlcfpmiOldXP: UInt32
    public let fcPlcfpmiNewXP: UInt32
    public let lcbPlcfpmiNewXP: UInt32
    public let fcPlcfpmiMixedXP: UInt32
    public let lcbPlcfpmiMixedXP: UInt32
    public let fcUnused2: UInt32
    public let lcbUnused2: UInt32
    public let fcPlcffactoid: UInt32
    public let lcbPlcffactoid: UInt32
    public let fcPlcflvcOldXP: UInt32
    public let lcbPlcflvcOldXP: UInt32
    public let fcPlcflvcNewXP: UInt32
    public let lcbPlcflvcNewXP: UInt32
    public let fcPlcflvcMixedXP: UInt32
    public let lcbPlcflvcMixedXP: UInt32
    
    public init(dataStream: inout DataStream, fibBase: FibBase, fibRgLw97: FibRgLw97) throws {
        /// rgFcLcb2000 (864 bytes): The contained FibRgFcLcb2000.
        self.rgFcLcb2000 = try FibRgFcLcb2000(dataStream: &dataStream, fibBase: fibBase, fibRgLw97: fibRgLw97)
        
        /// fcUnused1 (4 bytes): This value is undefined and MUST be ignored.
        self.fcUnused1 = try dataStream.read(endianess: .littleEndian)

        /// lcbUnused1 (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbUnused1 = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfPgp (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PGPArray begins at this offset. If lcbPlcfPgp
        /// is 0, fcPlcfPgp is undefined and MUST be ignored.
        self.fcPlcfPgp = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfPgp (4 bytes): An unsigned integer that specifies the size, in bytes, of the PGPArray that is stored at offset fcPlcfPgp.
        self.lcbPlcfPgp = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfuim (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A Plcfuim begins at this offset. If lcbPlcfuim
        /// is zero, fcPlcfuim is undefined and MUST be ignored.
        self.fcPlcfuim = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfuim (4 bytes): An unsigned integer that specifies the size, in bytes, of the Plcfuim at offset fcPlcfuim.
        self.lcbPlcfuim = try dataStream.read(endianess: .littleEndian)

        /// fcPlfguidUim (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlfguidUim begins at this offset. If
        /// lcbPlfguidUim is zero, fcPlfguidUim is undefined and MUST be ignored.
        self.fcPlfguidUim = try dataStream.read(endianess: .littleEndian)

        /// lcbPlfguidUim (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlfguidUim at offset fcPlfguidUim.
        self.lcbPlfguidUim = try dataStream.read(endianess: .littleEndian)

        /// fcAtrdExtra (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An AtrdExtra begins at this offset. If
        /// lcbAtrdExtra is zero, fcAtrdExtra is undefined and MUST be ignored.
        self.fcAtrdExtra = try dataStream.read(endianess: .littleEndian)

        /// lcbAtrdExtra (4 bytes): An unsigned integer that specifies the size, in bytes, of the AtrdExtra at offset fcAtrdExtra in the Table Stream.
        self.lcbAtrdExtra = try dataStream.read(endianess: .littleEndian)

        /// fcPlrsid (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PLRSID begins at this offset. If lcbPlrsid is zero,
        /// fcPlrsid is undefined and MUST be ignored.
        self.fcPlrsid = try dataStream.read(endianess: .littleEndian)

        /// lcbPlrsid (4 bytes): An unsigned integer that specifies the size, in bytes, of the PLRSID at offset fcPlrsid in the Table Stream.
        self.lcbPlrsid = try dataStream.read(endianess: .littleEndian)

        /// fcSttbfBkmkFactoid (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An SttbfBkmkFactoid containing
        /// information about smart tag bookmarks in the document begins at this offset. If lcbSttbfBkmkFactoid is zero, fcSttbfBkmkFactoid
        /// is undefined and MUST be ignored.
        /// The SttbfBkmkFactoid is parallel to the PlcfBkfd at offset fcPlcfBkfFactoid in the Table Stream. Each element in the SttbfBkmkFactoid
        /// specifies information about the bookmark that is associated with the data element which is located at the same offset in that PlcfBkfd.
        /// For this reason, the SttbfBkmkFactoid that begins at offset fcSttbfBkmkFactoid, and the PlcfBkfd that begins at offset
        /// fcPlcfBkfFactoid, MUST contain the same number of elements.
        self.fcSttbfBkmkFactoid = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbfBkmkFactoid (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbfBkmkFactoid at offset
        /// fcSttbfBkmkFactoid.
        self.lcbSttbfBkmkFactoid = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfBkfFactoid (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfBkfd that contains information
        /// about the smart tag bookmarks in the document begins at this offset. If lcbPlcfBkfFactoid is zero, fcPlcfBkfFactoid is undefined
        /// and MUST be ignored. Each data element in the PlcfBkfd is associated, in a one-to-one correlation, with a data element in the
        /// Plcfbkld at offset fcPlcfBklFactoid. For this reason, the PlcfBkfd that begins at offset fcPlcfBkfFactoid, and the Plcfbkld that begins
        /// at offset fcPlcfBklFactoid, MUST contain the same number of data elements. The PlcfBkfd is parallel to the SttbfBkmkFactoid at
        /// offset fcSttbfBkmkFactoid in the Table Stream. Each data element in the PlcfBkfd specifies information about the bookmark that is
        /// associated with the element which is located at the same offset in that SttbfBkmkFactoid. For this reason, the PlcfBkfd that begins
        /// at offset fcPlcfBkfFactoid, and the SttbfBkmkFactoid that begins at offset fcSttbfBkmkFactoid, MUST contain the same number of
        /// elements.
        self.fcPlcfBkfFactoid = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfBkfFactoid (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfBkfd at offset fcPlcfBkfFactoid.
        self.lcbPlcfBkfFactoid = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfcookie (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A Plcfcookie begins at this offset. If
        /// lcbPlcfcookie is zero, fcPlcfcookie is undefined and MUST be ignored. fcPlcfcookie MAY<79> be ignored.
        self.fcPlcfcookie = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfcookie (4 bytes): An unsigned integer that specifies the size, in bytes, of the Plcfcookie at offset fcPlcfcookie in the Table
        /// Stream.
        self.lcbPlcfcookie = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfBklFactoid (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A Plcfbkld that contains information
        /// about the smart tag bookmarks in the document begins at this offset. If lcbPlcfBklFactoid is zero, fcPlcfBklFactoid is undefined
        /// and MUST be ignored. Each data element in the Plcfbkld is associated, in a one-to-one correlation, with a data element in the
        /// PlcfBkfd at offset fcPlcfBkfFactoid. For this reason, the Plcfbkld that begins at offset fcPlcfBklFactoid, and the PlcfBkfd that
        /// begins at offset fcPlcfBkfFactoid, MUST contain the same number of data elements.
        self.fcPlcfBklFactoid = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfBklFactoid (4 bytes): An unsigned integer that specifies the size, in bytes, of the Plcfbkld at offset fcPlcfBklFactoid.
        self.lcbPlcfBklFactoid = try dataStream.read(endianess: .littleEndian)

        /// fcFactoidData (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A SmartTagData begins at this offset and
        /// specifies information about the smart tag recognizers that are used in this document. If lcbFactoidData is zero, fcFactoidData is
        /// undefined and MUST be ignored.
        self.fcFactoidData = try dataStream.read(endianess: .littleEndian)

        /// lcbFactoidData (4 bytes): An unsigned integer that specifies the size, in bytes, of the SmartTagData at offset fcFactoidData in the
        /// Table Stream.
        self.lcbFactoidData = try dataStream.read(endianess: .littleEndian)

        /// fcDocUndo (4 bytes): An unsigned integer that specifies an offset in the WordDocument Stream. Version-specific undo information
        /// begins at this offset. This information SHOULD NOT<80> be emitted and SHOULD<81> be ignored.
        self.fcDocUndo = try dataStream.read(endianess: .littleEndian)

        /// lcbDocUndo (4 bytes): An unsigned integer. If this value is nonzero, version-specific undo information exists at offset fcDocUndo in
        /// the WordDocument Stream.
        self.lcbDocUndo = try dataStream.read(endianess: .littleEndian)

        /// fcSttbfBkmkFcc (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An SttbfBkmkFcc that contains information
        /// about the format consistency-checker bookmarks in the document begins at this offset. If lcbSttbfBkmkFcc is zero, fcSttbfBkmkFcc
        /// is undefined and MUST be ignored.
        /// The SttbfBkmkFcc is parallel to the PlcfBkfd at offset fcPlcfBkfFcc in the Table Stream. Each element in the SttbfBkmkFcc specifies
        /// information about the bookmark that is associated with the data element which is located at the same offset in that PlcfBkfd. For
        /// this reason, the SttbfBkmkFcc that begins at offset fcSttbfBkmkFcc, and the PlcfBkfd that begins at offset fcPlcfBkfFcc, MUST
        /// contain the same number of elements.
        self.fcSttbfBkmkFcc = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbfBkmkFcc (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbfBkmkFcc at offset fcSttbfBkmkFcc.
        self.lcbSttbfBkmkFcc = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfBkfFcc (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfBkfd that contains information about
        /// format consistency-checker bookmarks in the document begins at this offset. If lcbPlcfBkfFcc is zero, fcPlcfBkfFcc is undefined
        /// and MUST be ignored. Each data element in the PlcfBkfd is associated, in a one-to-one correlation, with a data element in the
        /// PlcfBkld at offset fcPlcfBklFcc. For this reason, the PlcfBkfd that begins at offset fcPlcfBkfFcc and the PlcfBkld that begins at offset
        /// fcPlcfBklFcc MUST contain the same number of data elements. The PlcfBkfd is parallel to the SttbfBkmkFcc at offset
        /// fcSttbfBkmkFcc in the Table Stream. Each data element in the PlcfBkfd specifies information about the bookmark that is associated
        /// with the element which is located at the same offset in that SttbfBkmkFcc. For this reason, the PlcfBkfd that begins at offset
        /// fcPlcfBkfFcc and the SttbfBkmkFcc that begins at offset fcSttbfBkmkFcc MUST contain the same number of elements.
        self.fcPlcfBkfFcc = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfBkfFcc (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfBkfd at offset fcPlcfBkfFcc.
        self.lcbPlcfBkfFcc = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfBklFcc (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfBkld that contains information about
        /// the format consistency-checker bookmarks in the document begins at this offset. If lcbPlcfBklFcc is zero, fcPlcfBklFcc is undefined
        /// and MUST be ignored. Each data element in the PlcfBkld is associated, in a one-to-one correlation, with a data element in the
        /// PlcfBkfd at offset fcPlcfBkfFcc. For this reason, the PlcfBkld that begins at offset fcPlcfBklFcc, and the PlcfBkfd that begins at offset
        /// fcPlcfBkfFcc, MUST contain the same number of data elements.
        self.fcPlcfBklFcc = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfBklFcc (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfBkld at offset fcPlcfBklFcc.
        self.lcbPlcfBklFcc = try dataStream.read(endianess: .littleEndian)

        /// fcSttbfbkmkBPRepairs (4 bytes): An unsigned integer that specifies an offset in the Table Stream. An SttbfBkmkBPRepairs that
        /// contains information about the repair bookmarks in the document begins at this offset. If lcbSttbfBkmkBPRepairs is zero,
        /// fcSttbfBkmkBPRepairs is undefined and MUST be ignored.
        /// The SttbfBkmkBPRepairs is parallel to the PlcfBkf at offset fcPlcfBkfBPRepairs in the Table Stream. Each element in the
        /// SttbfBkmkBPRepairs specifies information about the bookmark that is associated with the data element which is located at the
        /// same offset in that PlcfBkf. For this reason, the SttbfBkmkBPRepairs that begins at offset fcSttbfBkmkBPRepairs, and the PlcfBkf
        /// that begins at offset fcPlcfBkfBPRepairs, MUST contain the same number of elements.
        self.fcSttbfbkmkBPRepairs = try dataStream.read(endianess: .littleEndian)

        /// lcbSttbfbkmkBPRepairs (4 bytes): An unsigned integer that specifies the size, in bytes, of the SttbfBkmkBPRepairs at offset
        /// fcSttbfBkmkBPRepairs.
        self.lcbSttbfbkmkBPRepairs = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfbkfBPRepairs (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfBkf that contains information
        /// about the repair bookmarks in the document begins at this offset. If lcbPlcfBkfBPRepairs is zero, fcPlcfBkfBPRepairs is undefined
        /// and MUST be ignored. Each data element in the PlcfBkf is associated, in a one-to-one correlation, with a data element in
        /// the PlcfBkl at offset fcPlcfBklBPRepairs. For this reason, the PlcfBkf that begins at offset fcPlcfBkfBPRepairs, and the PlcfBkl that
        /// begins at offset fcPlcfBklBPRepairs, MUST contain the same number of data elements. The PlcfBkf is parallel to the
        /// SttbfBkmkBPRepairs at offset fcSttbfBkmkBPRepairs in the Table Stream. Each data element in the PlcfBkf specifies
        /// information about the bookmark that is associated with the element which is located at the same offset in that SttbfBkmkBPRepairs.
        /// For this reason, the PlcfBkf that begins at offset fcPlcfbkfBPRepairs, and the SttbfBkmkBPRepairs that begins at offset
        /// fcSttbfBkmkBPRepairs, MUST contain the same number of elements. The CPs in this PlcfBkf MUST NOT exceed the CP that
        /// represents the end of the Main Document part.
        self.fcPlcfbkfBPRepairs = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfbkfBPRepairs (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfBkf at offset fcPlcfbkfBPRepairs.
        self.lcbPlcfbkfBPRepairs = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfbklBPRepairs (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A PlcfBkl that contains information
        /// about the repair bookmarks in the document begins at this offset. If lcbPlcfBklBPRepairs is zero, fcPlcfBklBPRepairs is undefined
        /// and MUST be ignored. Each data element in the PlcfBkl is associated, in a one-to-one correlation, with a data element in the
        /// PlcfBkf at offset fcPlcfBkfBPRepairs. For this reason, the PlcfBkl that begins at offset fcPlcfBklBPRepairs, and the PlcfBkf that
        /// begins at offset fcPlcfBkfBPRepairs, MUST contain the same number of data elements.
        /// The CPs that are contained in this PlcfBkl MUST NOT exceed the CP that represents the end of the Main Document part.
        self.fcPlcfbklBPRepairs = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfbklBPRepairs (4 bytes): An unsigned integer that specifies the size, in bytes, of the PlcfBkl at offset fcPlcfBklBPRepairs.
        self.lcbPlcfbklBPRepairs = try dataStream.read(endianess: .littleEndian)

        /// fcPmsNew (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A new Pms, which contains the current state
        /// of a print merge operation, begins at this offset. If lcbPmsNew is zero, fcPmsNew is undefined and MUST be ignored.
        self.fcPmsNew = try dataStream.read(endianess: .littleEndian)

        /// lcbPmsNew (4 bytes): An unsigned integer which specifies the size, in bytes, of the Pms at offset fcPmsNew.
        self.lcbPmsNew = try dataStream.read(endianess: .littleEndian)

        /// fcODSO (4 bytes): An unsigned integer that specifies an offset in the Table Stream. Office Data Source Object (ODSO) data that is
        /// used to perform mail merge begins at this offset. The data is stored in an array of ODSOPropertyBase items. The ODSOPropertyBase
        /// items are of variable size and are stored contiguously. The complete set of properties that are contained in the array is determined
        /// by reading each ODSOPropertyBase, until a total of lcbODSO bytes of data are read. If lcbODSO is zero, fcODSO is undefined and
        /// MUST be ignored.
        self.fcODSO = try dataStream.read(endianess: .littleEndian)

        /// lcbODSO (4 bytes): An unsigned integer that specifies the size, in bytes, of the Office Data Source Object data at offset fcODSO
        /// in the Table Stream.
        self.lcbODSO = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfpmiOldXP (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated paragraph mark
        /// information cache begins at this offset. Information SHOULD NOT<82> be emitted at this offset and SHOULD<83> be ignored. If
        /// lcbPlcfpmiOldXP is zero, fcPlcfpmiOldXP is undefined and MUST be ignored.
        self.fcPlcfpmiOldXP = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfpmiOldXP (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated paragraph mark information
        /// cache at offset fcPlcfpmiOldXP in the Table Stream. This value SHOULD<84> be zero.
        self.lcbPlcfpmiOldXP = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfpmiNewXP (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated paragraph mark
        /// information cache begins at this offset. Information SHOULD NOT<85> be emitted at this offset and SHOULD<86> be ignored.
        /// If lcbPlcfpmiNewXP is zero, fcPlcfpmiNewXP is undefined and MUST be ignored.
        self.fcPlcfpmiNewXP = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfpmiNewXP (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated paragraph mark information
        /// cache at offset fcPlcfpmiNewXP in the Table Stream. This value SHOULD<87> be zero.
        self.lcbPlcfpmiNewXP = try dataStream.read(endianess: .littleEndian)

        /// fcPlcfpmiMixedXP (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated paragraph mark
        /// information cache begins at this offset. Information SHOULD NOT<88> be emitted at this offset and SHOULD<89> be ignored.
        /// If lcbPlcfpmiMixedXP is zero, fcPlcfpmiMixedXP is undefined and MUST be ignored.
        self.fcPlcfpmiMixedXP = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcfpmiMixedXP (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated paragraph mark information
        /// cache at offset fcPlcfpmiMixedXP in the Table Stream. This value SHOULD<90> be zero.
        self.lcbPlcfpmiMixedXP = try dataStream.read(endianess: .littleEndian)

        /// fcUnused2 (4 bytes): This value is undefined and MUST be ignored.
        self.fcUnused2 = try dataStream.read(endianess: .littleEndian)

        /// lcbUnused2 (4 bytes): This value MUST be zero, and MUST be ignored.
        self.lcbUnused2 = try dataStream.read(endianess: .littleEndian)

        /// fcPlcffactoid (4 bytes): An unsigned integer that specifies an offset in the Table Stream. A Plcffactoid, which specifies the smart
        /// tag recognizer state of each text range, begins at this offset. If lcbPlcffactoid is zero, fcPlcffactoid is undefined and MUST be ignored.
        self.fcPlcffactoid = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcffactoid (4 bytes): An unsigned integer that specifies the size, in bytes of the Plcffactoid that begins at offset fcPlcffactoid in
        /// the Table Stream.
        self.lcbPlcffactoid = try dataStream.read(endianess: .littleEndian)

        /// fcPlcflvcOldXP (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated listnum field cache begins
        /// at this offset. Information SHOULD NOT<91> be emitted at this offset and SHOULD<92> be ignored. If lcbPlcflvcOldXP is zero,
        /// fcPlcflvcOldXP is undefined and MUST be ignored.
        self.fcPlcflvcOldXP = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcflvcOldXP (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated listnum field cache at offset
        /// fcPlcflvcOldXP in the Table Stream. This value SHOULD<93> be zero.
        self.lcbPlcflvcOldXP = try dataStream.read(endianess: .littleEndian)

        /// fcPlcflvcNewXP (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated listnum field cache
        /// begins at this offset. Information SHOULD NOT<94> be emitted at this offset and SHOULD<95> be ignored. If lcbPlcflvcNewXP
        /// is zero, fcPlcflvcNewXP is undefined and MUST be ignored.
        self.fcPlcflvcNewXP = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcflvcNewXP (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated listnum field cache at offset
        /// fcPlcflvcNewXP in the Table Stream. This value SHOULD<96> be zero.
        self.lcbPlcflvcNewXP = try dataStream.read(endianess: .littleEndian)

        /// fcPlcflvcMixedXP (4 bytes): An unsigned integer that specifies an offset in the Table Stream. The deprecated listnum field cache
        /// begins at this offset. Information SHOULD NOT<97> be emitted at this offset and SHOULD<98> be ignored. If lcbPlcflvcMixedXP
        /// is zero, fcPlcflvcMixedXP is undefined and MUST be ignored.
        self.fcPlcflvcMixedXP = try dataStream.read(endianess: .littleEndian)

        /// lcbPlcflvcMixedXP (4 bytes): An unsigned integer that specifies the size, in bytes, of the deprecated listnum field cache at offset
        /// fcPlcflvcMixedXP in the Table Stream. This value SHOULD<99> be zero.
        self.lcbPlcflvcMixedXP = try dataStream.read(endianess: .littleEndian)
    }
}
