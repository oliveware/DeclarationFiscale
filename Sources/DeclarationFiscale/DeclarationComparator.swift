//
//  DeclarationComparator.swift
//  DeclarationFiscale
//
//  Created by Herve Crespel on 27/09/2026.
//

import SwiftUI

public struct DeclarationComparator: View {
    @Binding var declaration: [String:String]
    var previous: [String:String]
    var real: [String:String]
    var schema: DeclarationSchema
    
    var headers:[String] { Array(declaration.keys) }
    
    init(declaration: Binding<[String : String]>, previous: [String : String], real: [String : String], schema: DeclarationSchema) {
        _declaration = declaration
        self.previous = previous
        self.real = real
        self.schema = schema
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                ForEach(Array(schema.groups), id:\.0) { group in
                    GroupBox(group.0) {
                        LazyVGrid(
                            columns: [
                            GridItem(.flexible(minimum: 220), alignment: .leading),
                          //  GridItem(.flexible(minimum: 220), alignment: .leading)
                        ], alignment: .leading,
                            spacing: 12) {
                            ForEach(group.1.filter { headers.contains($0) }, id: \.self) { key in
                                FieldComparator(
                                    key: key,
                                    label: schema.label(for: key),
                                    value: Binding(
                                        get: { declaration[key] ?? ""},
                                        set: { declaration[key] = $0 }
                                    ),
                                    previous: previous[key] ?? "",
                                    real: real[key] ?? ""
                                )
                            }
                        }
                        .padding(6)
                    }
                }

                if headers.count != schema.headers.count {
                    GroupBox("Colonnes supplémentaires") {
                        Text("Le fichier importé contient \(headers.count) colonnes. Les colonnes qui ne sont pas dans le schéma 2025 sont conservées et seront exportées.")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
        }
       // .navigationTitle(model.value("noFiscalDuLocal").isEmpty ? "Déclaration de bien" : model.value("noFiscalDuLocal"))
    }
}

func declaration(_ headers:[String],_ string:String) -> [String:String] {
    var declare : [String:String] = [:]
    for header in  headers {
        declare[header] = string
    }
    return declare
}

struct DeclarationPrecomparator: View {
    @State var model : [String:String]
    var previous: [String:String]
    var real: [String:String]
    var schema = bienSchema
    init() {
        model = declaration(schema.headers, "model")
       real = declaration(schema.headers, "real")
        previous = declaration(schema.headers, "avant")
    }
    
    var body: some View {
        ScrollView {
            DeclarationComparator(declaration:$model, previous:previous, real: real, schema: schema)
        }
    }
}

#Preview {
    DeclarationPrecomparator()
        .frame(width:700)
}
