import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @StateObject private var model = AppModel()
    @State private var showingImporter = false
    @State private var showingExporter = false
    @State private var showingValidation = false
    @State private var validationIssues: [ValidationIssue] = []
    
    var live:[[String: String]] = []

    var body: some View {
        NavigationSplitView {
            VStack(spacing: 0) {
                HStack {
                    TextField("Rechercher…", text: $model.searchText)
                        .textFieldStyle(.roundedBorder)
                 /*   Button { model.newDeclaration(live) } label: {
                        Image(systemName: "plus")
                    }
                    .help("Nouvelle déclaration")*/
                }
                .padding()

                List(selection: $model.selectedIndex) {
                    ForEach(model.filteredIndices, id: \.self) { index in
                        DeclarationRow(row: model.declarations[index], index: index, kind:model.kind)
                            .tag(index as Int?)
                    }
                }
            }
            .navigationTitle(model.kind.rawValue + "s")
            .frame(minWidth: 300)
        } detail: {
            if model.selectedIndex != nil {
                DeclarationEditor(model: model)
            } else {
                if model.declarations.isEmpty {
                    Text("charger un fichier CSV")
                } else {
                    Text("Choisir \(model.kind.rawValue)")
                }
                
               /* ContentUnavailableView(
                    "Aucune déclaration",
                    systemImage: "doc.text",
                    description: Text("Créez une déclaration ou importez un fichier CSV.")
                )*/
            }
        }
        .toolbar {
            ToolbarItemGroup {
              /*  Button { model.newDeclaration(live) } label: {
                    Label("Nouveau", systemImage: "plus")
                }
                Button { model.duplicateSelected() } label: {
                    Label("Dupliquer", systemImage: "plus.square.on.square")
                }*/
                Button(role: .destructive) { model.deleteSelected() } label: {
                    Label("Supprimer", systemImage: "trash")
                }
                Divider()
                Button { showingImporter = true } label: {
                    Label("Importer CSV", systemImage: "square.and.arrow.down")
                }
                Button {
                    validationIssues = currentValidation()
                    showingValidation = true
                } label: {
                    Label("Valider", systemImage: "checkmark.shield")
                }
                Button { showingExporter = true } label: {
                    Label("Exporter CSV", systemImage: "square.and.arrow.up")
                }
            }
        }
        .fileImporter(
            isPresented: $showingImporter,
            allowedContentTypes: [.commaSeparatedText, .text],
            allowsMultipleSelection: false
        ) { result in
            if case .success(let urls) = result, let url = urls.first {
                model.importCSV(url: url)
            }
        }
        .fileExporter(
            isPresented: $showingExporter,
            document: CSVFileDocument(headers: model.headers, rows: model.declarations),
            contentType: .commaSeparatedText,
            defaultFilename: model.kind.filename + ".csv"
        ) { result in
            switch result {
            case .success: model.status = "Export terminé"
            case .failure(let error): model.status = "Erreur : \(error.localizedDescription)"
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Text(model.status)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(model.declarations.count) \(model.kind.rawValue)(s)")
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
            .padding(.vertical, 6)
            .background(.bar)
        }
        .sheet(isPresented: $showingValidation) {
            ValidationView(issues: validationIssues)
                .frame(minWidth: 520, minHeight: 320)
        }
    }

    private func currentValidation() -> [ValidationIssue] {
        guard let i = model.selectedIndex else { return [] }
        return Validator.validate(row: model.declarations[i], headers: model.headers)
    }
}

struct DeclarationEditor: View {
    @ObservedObject var model: AppModel

    var body: some View {
        switch model.kind {
        case .bien : BienEditor(model: model)
        case .occupation: OccupationEditor(model: model)
        }
    }
}

struct DeclarationRow: View {
    let row: [String: String]
    let index: Int
    let kind : AppModel.Kind

    var body: some View {
        switch kind {
        case .bien : BienRow(row: row, index: index)
        case .occupation: OccupationRow(row: row, index: index)
        }
    }
}

struct FieldEditor: View {
    let key: String
    let label: String
    @Binding var value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
            if key == "observation" {
                TextEditor(text: $value)
                    .frame(minHeight: 80)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(.quaternary))
            } else {
                TextField(label, text: $value)
                    .textFieldStyle(.roundedBorder)
            }
        }
    }
}

struct ValidationView: View {
    let issues: [ValidationIssue]
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
                        Text(OccupationCSVSchema.label(for: issue.field)).font(.headline)
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
