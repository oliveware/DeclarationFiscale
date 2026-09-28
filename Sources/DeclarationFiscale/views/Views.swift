
import SwiftUI
import UniformTypeIdentifiers

struct DeclarationRow: View {
    let row: [String: String]
    let index: Int
    let kind : DeclarationModel.Kind

    var body: some View {
        switch kind {
        case .bien : BienRow(row: row, index: index)
        case .occupation: OccupationRow(row: row, index: index)
        }
    }
}



struct ValidationView: View {
    let issues: [ValidationIssue]
    var schema: DeclarationSchema
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Image(systemName: issues.isEmpty ? "checkmark.circle" : "exclamationmark.triangle")
                Text(issues.isEmpty ? "Validation réussie" : "\(issues.count) problème(s)")
                    .font(.title2.bold())
                Spacer()
                Button("Fermer") { dismiss() }
            }

            if issues.isEmpty {
                Text("Aucune anomalie détectée par les contrôles locaux.")
                    .foregroundStyle(.secondary)
            } else {
                List(issues) { issue in
                    VStack(alignment: .leading) {
                        Text(schema.label(for: issue.field)).font(.headline)
                        Text(issue.message).foregroundStyle(.secondary)
                    }
                }
            }
        }
        .padding()
    }
}

struct CSVFileDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.commaSeparatedText, .text] }

    let data: Data

    init(headers: [String], rows: [[String: String]]) {
        data = CSVDocument(headers: headers, rows: rows).encoded()
    }

    init(configuration: ReadConfiguration) throws {
        data = configuration.file.regularFileContents ?? Data()
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: data)
    }
}
