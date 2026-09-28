//
//  DeclarationsManager.swift
//  DeclarationFiscale
//
//  Created by Herve Crespel on 27/09/2026.
//

import SwiftUI
/*
struct DeclarationsManager: View {
    @StateObject private var model = DeclarationModel()
    @State private var showingImporter = false
    @State private var showingExporter = false
    @State private var showingValidation = false
    @State private var validationIssues: [ValidationIssue] = []
    var schema :DeclarationSchema
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
                        DeclarationRow(row: model.declarations[index], index: index)
                            .tag(index as Int?)
                    }
                }
            }
           // .navigationTitle(model.kind.rawValue + "s")
            .frame(minWidth: 300)
        } detail: {
            if model.selectedIndex != nil {
                DeclarationEditor(model: model, schema:schema)
            } else {
                if model.declarations.isEmpty {
                    Text("charger un fichier CSV")
                } else {
                    Text("Choisir \()")
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
            ValidationView(issues: validationIssues, schema:schema)
                .frame(minWidth: 520, minHeight: 320)
        }
    }

    private func currentValidation() -> [ValidationIssue] {
        guard let i = model.selectedIndex else { return [] }
        return Validator.validate(row: model.declarations[i], headers: model.headers)
    }
}
*/
