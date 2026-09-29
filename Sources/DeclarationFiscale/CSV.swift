import Foundation
import SwiftUI
import UniformTypeIdentifiers

enum CSVError: LocalizedError {
    case invalidHeader
    case malformed(String)

    var errorDescription: String? {
        switch self {
        case .invalidHeader: return "Le fichier CSV ne contient pas d'en-tête."
        case .malformed(let message): return "CSV invalide : \(message)"
        }
    }
}

public struct CSVFileDocument: FileDocument {
    public static var readableContentTypes: [UTType] { [.commaSeparatedText, .text] }

    let data: Data

    init(headers: [String], rows: [[String: String]]) {
        data = CSVDocument(headers: headers, rows: rows).encoded()
    }

    public init(configuration: ReadConfiguration) throws {
        data = configuration.file.regularFileContents ?? Data()
    }

    public func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: data)
    }
}

public struct CSVDocument {
    var headers: [String]
    var rows: [[String: String]]
    var status = ""
    var kind = Kind.occupation
    enum Kind: String {
        case occupation = "occupation"
        case bien = "bien"
        var titre: String {
            switch self {
            case .bien : "déclaration de bien"
            case .occupation : "déclaration d'occupation de bien"
            }
        }
        var filename: String {
            switch self {
            case .bien : "declarationbien"
            case .occupation : "declarationoccupation"
            }
        }
    }

    public init(headers: [String] = [], rows: [[String: String]] = []) {
        self.headers = headers
        self.rows = rows
    }

    static func parse(data: Data) throws -> CSVDocument {
        var text = String(data: data, encoding: .utf8)
        if text == nil { text = String(data: data, encoding: .windowsCP1252) }
        guard var text else { throw CSVError.malformed("encodage non reconnu") }

        if text.first == "\u{FEFF}" { text.removeFirst() }

        let matrix = try CSVParser.parse(text)
        guard let headerRow = matrix.first, !headerRow.isEmpty else {
            throw CSVError.invalidHeader
        }

        let headers = headerRow
        let rows = matrix.dropFirst().map { row in
            var dict: [String: String] = [:]
            for (i, header) in headers.enumerated() {
                dict[header] = i < row.count ? row[i] : ""
            }
            return dict
        }
        return CSVDocument(headers: headers, rows: rows)
    }

    func encoded() -> Data {
        let lines = [headers] + rows.map { row in headers.map { row[$0] ?? "" } }
        let body = lines.map { $0.map(CSVParser.escape).joined(separator: ";") }.joined(separator: "\r\n")
        return Data(("\u{FEFF}" + body + "\r\n").utf8)
    }
    
    public mutating func importCSV(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            let doc = try CSVDocument.parse(data: data)
            headers = doc.headers
            rows = doc.rows
           // selectedIndex = declarations.isEmpty ? nil : 0
            if headers[0] == "declarer" {
                status = "\(rows.count) occupation(s) importée(s)"
                kind = .occupation
            } else {
                status = "\(rows.count) bien(s) importé(s)"
                kind = .bien
            }
        } catch {
            status = "Erreur : \(error.localizedDescription)"
        }
    }
    
    public mutating func exportCSV(url: URL) {
        let doc = CSVDocument(headers: headers, rows: rows)
        do {
            try doc.encoded().write(to: url, options: .atomic)
            status = "\(rows.count) déclaration(s) exportée(s)"
        } catch {
            status = "Erreur d'export : \(error.localizedDescription)"
        }
    }
}

enum CSVParser {
    static func parse(_ text: String) throws -> [[String]] {
        var result: [[String]] = []
        var row: [String] = []
        var field = ""
        var quoted = false
        var i = text.startIndex

        while i < text.endIndex {
            let c = text[i]
            if quoted {
                if c == "\"" {
                    let next = text.index(after: i)
                    if next < text.endIndex && text[next] == "\"" {
                        field.append("\"")
                        i = next
                    } else {
                        quoted = false
                    }
                } else {
                    field.append(c)
                }
            } else {
                switch c {
                case "\"":
                    quoted = true
                case ";":
                    row.append(field); field = ""
                case "\n":
                    row.append(field); field = ""
                    if row.last == "\r" { row.removeLast() }
                    result.append(row); row = []
                case "\r":
                    let next = text.index(after: i)
                    if next < text.endIndex && text[next] == "\n" {
                        i = next
                    } else {
                        row.append(field); field = ""
                        result.append(row); row = []
                    }
                default:
                    field.append(c)
                }
            }
            i = text.index(after: i)
        }

        if quoted { throw CSVError.malformed("guillemet non fermé") }
        if !field.isEmpty || !row.isEmpty {
            row.append(field)
            result.append(row)
        }
        return result.filter { !($0.count == 1 && $0[0].isEmpty) }
    }

    static func escape(_ value: String) -> String {
        if value.contains(";") || value.contains("\"") || value.contains("\n") || value.contains("\r") {
            return "\"" + value.replacingOccurrences(of: "\"", with: "\"\"") + "\""
        }
        return value
    }
}
