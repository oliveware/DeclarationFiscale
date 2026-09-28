//
//  BienEditor.swift
//  DeclarationOccupation
//
//  Created by Herve Crespel on 15/09/2026.
//

import SwiftUI

struct BienRow: View {
    let row: [String: String]
    let index: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(row["voie"]?.isEmpty == false ? row["voie"]! : "Bien \(index + 1)")
                .font(.headline)
            Text([row["commune"], row["              voie"]]
                .compactMap { $0 }.filter { !$0.isEmpty }.joined(separator: " — "))
                .foregroundStyle(.secondary)
                .lineLimit(1)
            Text([row["cdDescHab"], row["surface"]]
                .compactMap { $0 }.filter { !$0.isEmpty }.joined(separator: " "))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 2)
    }
}

/*struct BienEditor: View {
    @ObservedObject var model: AppModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                ForEach(Array(BienCSVSchema.groups.enumerated()), id: \.offset) { _, group in
                    GroupBox(group.0) {
                        LazyVGrid(columns: [
                            GridItem(.flexible(minimum: 220), alignment: .leading),
                            GridItem(.flexible(minimum: 220), alignment: .leading)
                        ], alignment: .leading, spacing: 12) {
                            ForEach(group.1.filter { model.headers.contains($0) }, id: \.self) { key in
                                FieldEditor(
                                    key: key,
                                    label: BienCSVSchema.label(for: key),
                                    value: Binding(
                                        get: { model.value(key) },
                                        set: { model.setValue(key, $0) }
                                    )
                                )
                            }
                        }
                        .padding(6)
                    }
                }

                if model.headers.count != BienCSVSchema.headers.count {
                    GroupBox("Colonnes supplémentaires") {
                        Text("Le fichier importé contient \(model.headers.count) colonnes. Les colonnes qui ne sont pas dans le schéma 2025 sont conservées et seront exportées.")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
        }
        .navigationTitle(model.value("noFiscalDuLocal").isEmpty ? "Déclaration de bien" : model.value("noFiscalDuLocal"))
    }
}*/
