# OfficeFileReader

# MsgReader

Swift definitions for structures, enumerations and functions defined in  [MS-DOC](https://learn.microsoft.com/en-us/openspecs/office_file_formats/ms-doc/) and  [MS-PPT](https://learn.microsoft.com/en-us/openspecs/office_file_formats/ms-ppt/)

## Example Usage

Add the following line to your project's SwiftPM dependencies:
```swift
.package(url: "https://github.com/hughbe/OfficeFileReader", from: "1.0.0"),
```

To read .doc files:

```swift
import OfficeFileReader

let data = Data(contentsOfFile: "<path-to-file>.doc")!
let file = try DocFile(data: data)
print(file)
```

To read .ppt files:

```swift
import OfficeFileReader

let data = Data(contentsOfFile: "<path-to-file>.ppt")!
let file = try PptFile(data: data)
print(file)
```
