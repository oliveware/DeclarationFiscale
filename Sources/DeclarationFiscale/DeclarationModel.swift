import Foundation
import SwiftUI

public final class DeclarationModel: ObservableObject {
    @Published var headers:     [String] = []
    @Published var declarations: [[String: String]] = []
    
    @Published var selectedIndex: Int? = nil
    @Published var searchText = ""
    @Published var status = "Prêt"
    
   
    /*func set(_ kind:Kind) {
        self.kind = kind
        switch kind {
        case .bien : headers = bienSchema.headers
        case .occupation : headers = occupationSchema.headers
        }
        var declaration : [String: String] = [:]
        for header in headers {
            declaration[header] = ""
        }
    }*/
    
    

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



    func resetSchemaIfNeeded() {
        if headers.isEmpty {
            switch kind {
            case .bien : headers = bienSchema.headers
            case .occupation : headers = occupationSchema.headers
            }
        }
    }
}
