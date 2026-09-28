//
//  OccupationEditor.swift
//  DeclarationOccupation
//
//  Created by Herve Crespel on 15/09/2026.
//
import SwiftUI

struct OccupationRow: View {
    let row: [String: String]
    let index: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(row["noFiscalDuLocal"]?.isEmpty == false ? "local " + row["noFiscalDuLocal"]! : "Déclaration \(index + 1)")
                .font(.headline)
            Text([row["libelle_commune"], row["libelle_voie"]]
                .compactMap { $0 }.filter { !$0.isEmpty }.joined(separator: " — "))
                .foregroundStyle(.secondary)
                .lineLimit(1)
            Text([row["nomNaissOcc_1"], row["prenomOcc_1"], row["denomSoc_1"]]
                .compactMap { $0 }.filter { !$0.isEmpty }.joined(separator: " "))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 2)
    }
}

