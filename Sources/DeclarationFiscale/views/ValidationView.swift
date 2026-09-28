
import SwiftUI

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


