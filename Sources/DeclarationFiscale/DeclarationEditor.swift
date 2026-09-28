//
//  DeclarationEditor.swift
//  DeclarationFiscale
//
//  Created by Herve Crespel on 27/09/2026.
//
import SwiftUI

public struct DeclarationEditor: View {
    @ObservedObject var model: DeclarationModel
    var schema: DeclarationSchema

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                ForEach(Array(schema.groups.enumerated()), id: \.offset) { _, group in
                    GroupBox(group.0) {
                        LazyVGrid(columns: [
                            GridItem(.flexible(minimum: 220), alignment: .leading),
                         //   GridItem(.flexible(minimum: 220), alignment: .leading)
                        ], alignment: .leading, spacing: 12) {
                            ForEach(group.1.filter { model.headers.contains($0) }, id: \.self) { key in
                                FieldEditor(
                                    key: key,
                                    label: schema.label(for: key),
                                  //  previousValue: model.previous[key],
                                   // liveValue: model.live,
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

                if model.headers.count != schema.headers.count {
                    GroupBox("Colonnes supplémentaires") {
                        Text("Le fichier importé contient \(model.headers.count) colonnes. Les colonnes qui ne sont pas dans le schéma 2025 sont conservées et seront exportées.")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
        }
        .navigationTitle("Déclaration d'occupation" + (model.value("noFiscalDuLocal").isEmpty ?  "" : " du local " + model.value("noFiscalDuLocal")))
    }
}
