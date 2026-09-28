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
