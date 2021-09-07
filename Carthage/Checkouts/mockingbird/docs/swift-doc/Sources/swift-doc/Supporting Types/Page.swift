import Foundation
import SwiftDoc
import SwiftMarkup
import SwiftSemantics
import struct SwiftSemantics.Protocol
import CommonMark
import HypertextLiteral

protocol Page: HypertextLiteralConvertible {
    var module: Module { get }
    var baseURL: String { get }
    var title: String { get }
    var document: CommonMark.Document { get }
    var html: HypertextLiteral.HTML { get }
}

extension Page {
    var module: Module { fatalError("unimplemented") }
    var title: String { fatalError("unimplemented") }
}

extension Page {
    func write(to url: URL, format: SwiftDoc.Generate.Format) throws {
        let data: Data?
        switch format {
        case .commonmark:
            data = document.render(format: .commonmark).data(using: .utf8)
        case .html:
            data = layout(self).description.data(using: .utf8)
        }

        guard let filedata = data else { return }

        try writeFile(filedata, to: url)
    }
}

func route(for symbol: Symbol) -> String {
    let description = route(for: symbol.id)
    guard let shortHash = symbol.declaration.map { $0.text }.joined().hashed()?.lowercased().prefix(7) else {
        return description
    }
    return description + "-" + shortHash
}

func route(for name: CustomStringConvertible) -> String {
    return name.description.replacingOccurrences(of: ".", with: "_")
}

func path(for symbol: Symbol, with baseURL: String) -> String {
    return path(for: route(for: symbol), with: baseURL)
}

func path(for identifier: CustomStringConvertible, with baseURL: String) -> String {
    var urlComponents = URL(string: baseURL)
    urlComponents = urlComponents?.appendingPathComponent("\(identifier)")
    guard let string = urlComponents?.absoluteString else {
        logger.critical("Unable to construct path for \(identifier) with baseURL \(baseURL)")
        fatalError()
    }
    
    return string
}

func writeFile(_ data: Data, to url: URL) throws {
    let fileManager = FileManager.default
    try fileManager.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
    try data.write(to: url)
}
