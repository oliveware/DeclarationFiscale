import Foundation

struct ValidationIssue: Identifiable {
    let id = UUID()
    let field: String
    let message: String
}

enum Validator {
    static func validate(row: [String: String], headers: [String]) -> [ValidationIssue] {
        var issues: [ValidationIssue] = []

        let numericFields = [
            "nbPiecesPpales","surface","surfacePrincipale","surfaceSecCouv",
            "surfaceSecNonCouv","surfaceParkCouv","surfaceParkNonCouv","loyerMensu",
            "noVoirie","noPlan","siren_1","siren_2","sirenGestionnaire",
            "sirenPersonnePhysique","siren_delegataire"
        ]

        for field in numericFields where headers.contains(field) {
            let value = row[field, default: ""].trimmingCharacters(in: .whitespacesAndNewlines)
            guard !value.isEmpty else { continue }
            if field.hasPrefix("siren") {
                if value.range(of: #"^\d{9}$"#, options: .regularExpression) == nil {
                    issues.append(.init(field: field, message: "Le SIREN doit comporter 9 chiffres."))
                }
            } else if Double(value.replacingOccurrences(of: ",", with: ".")) == nil {
                issues.append(.init(field: field, message: "Valeur numérique attendue."))
            }
        }

        let dateFields = headers.filter {
            $0.hasPrefix("dte")
        }
        for field in dateFields {
            let value = row[field, default: ""].trimmingCharacters(in: .whitespacesAndNewlines)
            guard !value.isEmpty else { continue }
            let accepted = ["dd/MM/yyyy", "yyyy-MM-dd", "dd-MM-yyyy"]
            let ok = accepted.contains { format in
                let f = DateFormatter()
                f.locale = Locale(identifier: "fr_FR")
                f.dateFormat = format
                return f.date(from: value) != nil
            }
            if !ok {
                issues.append(.init(field: field, message: "Format de date non reconnu (JJ/MM/AAAA ou AAAA-MM-JJ)."))
            }
        }

        return issues
    }
}
