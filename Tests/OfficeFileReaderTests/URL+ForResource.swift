import Foundation

fileprivate let _resources: URL = {
    func packageRoot(of file: String) -> URL? {
        func isPackageRoot(_ url: URL) -> Bool {
            let filename = url.appendingPathComponent("Package.swift", isDirectory: false)
            return FileManager.default.fileExists(atPath: filename.path)
        }

        var url = URL(fileURLWithPath: file, isDirectory: false)
        repeat {
            url = url.deletingLastPathComponent()
            if url.pathComponents.count <= 1 {
                return nil
            }
        } while !isPackageRoot(url)
        return url
    }

    guard let root = packageRoot(of: #file) else {
        fatalError("\(#file) must be contained in a Swift Package Manager project.")
    }
    let fileComponents = URL(fileURLWithPath: #file, isDirectory: false).pathComponents
    let rootComponenets = root.pathComponents
    let trailingComponents = Array(fileComponents.dropFirst(rootComponenets.count))
    let resourceComponents = rootComponenets + trailingComponents[0...1] + ["Resources"]
    return URL(fileURLWithPath: resourceComponents.joined(separator: "/"), isDirectory: true)
}()

extension URL {
    init(forResource name: String, withExtension extensionName: String) {
        let url = _resources.appendingPathComponent("\(name).\(extensionName)", isDirectory: false)
        self = url
    }
}
