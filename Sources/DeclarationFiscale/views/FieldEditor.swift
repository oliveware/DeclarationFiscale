//
//  FieldEditor.swift
//  DeclarationFiscale
//
//  Created by Herve Crespel on 27/09/2026.
//
import SwiftUI

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
