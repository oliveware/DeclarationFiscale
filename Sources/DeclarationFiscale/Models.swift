import Foundation
import SwiftUI

final class AppModel: ObservableObject {
    @Published var headers:     [String] = []
    @Published var declarations: [[String: String]] = []
    
    @Published var selectedIndex: Int? = nil
    @Published var searchText = ""
    @Published var status = "Prêt"
    
    var kind = Kind.occupation
    func set(_ kind:Kind) {
        self.kind = kind
        switch kind {
        case .bien : headers = BienCSVSchema.headers
        case .occupation : headers = OccupationCSVSchema.headers
        }
        
    }
    
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

    var filteredIndices: [Int] {
        guard !searchText.isEmpty else { return Array(declarations.indices) }
        let needle = searchText.folding(options: .diacriticInsensitive, locale: .current).lowercased()
        return declarations.indices.filter { i in
            let values = declarations[i].values.joined(separator: " ")
            return values.folding(options: .diacriticInsensitive, locale: .current).lowercased().contains(needle)
        }
    }

   func newDeclaration(_ values:[[String: String]]) {
        var row: [String: String] = [:]
        headers.forEach { row[$0] = "" }
        declarations.append(row)
        selectedIndex = declarations.count - 1
        status = "Nouvelle déclaration"
    }

    func duplicateSelected() {
        guard let i = selectedIndex, declarations.indices.contains(i) else { return }
        declarations.insert(declarations[i], at: i + 1)
        selectedIndex = i + 1
        status = "Déclaration dupliquée"
    }

    func deleteSelected() {
        guard let i = selectedIndex, declarations.indices.contains(i) else { return }
        declarations.remove(at: i)
        selectedIndex = declarations.isEmpty ? nil : min(i, declarations.count - 1)
        status = "Déclaration supprimée"
    }

    func value(_ key: String) -> String {
        guard let i = selectedIndex else { return "" }
        return declarations[i][key] ?? ""
    }

    func setValue(_ key: String, _ value: String) {
        guard let i = selectedIndex, declarations.indices.contains(i) else { return }
        declarations[i][key] = value
    }

    func importCSV(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            let doc = try CSVDocument.parse(data: data)
            headers = doc.headers
            declarations = doc.rows
            selectedIndex = declarations.isEmpty ? nil : 0
            if headers[0] == "declarer" {
                status = "\(declarations.count) occupation(s) importée(s)"
                kind = .occupation
            } else {
                status = "\(declarations.count) bien(s) importé(s)"
                kind = .bien
            }
        } catch {
            status = "Erreur : \(error.localizedDescription)"
        }
    }

    func exportCSV(url: URL) {
        let doc = CSVDocument(headers: headers, rows: declarations)
        do {
            try doc.encoded().write(to: url, options: .atomic)
            status = "\(declarations.count) déclaration(s) exportée(s)"
        } catch {
            status = "Erreur d'export : \(error.localizedDescription)"
        }
    }

    func resetSchemaIfNeeded() {
        if headers.isEmpty {
            switch kind {
            case .bien : headers = BienCSVSchema.headers
            case .occupation : headers = OccupationCSVSchema.headers
            }
        }
    }
}
