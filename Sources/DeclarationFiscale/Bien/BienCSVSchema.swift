//
//  BienCSVSchema.swift
//  DeclarationOccupation
//
//  Created by Herve Crespel on 15/09/2026.
//

enum BienCSVSchema {
    static let headers: [String] = ["invariant",
        "typeLocal","typeDesc","cdDept","cdCommune","cdVoie","noVoirie","indRep", "voie","departement","commune","cdPrefix","cdSection","noPlan","noBatiment","noEscalier","noEtage","noPorte","lots","cdNature","cdConstParticuliere","nbPiecesPpales","cdDescHab","surface","categorie","surfacePrincipale","surfaceSecCouv","surfaceSecNonCouv","surfaceParkCouv","surfaceParkNonCouv","droits","indivision","noPermis","identifiantProvisoire","spi_delegataire","siren_delegataire"]
    
    static let groups: [(String, [String])] = [
        ("id", ["invariant"]),
        ("Adresse", ["typeLocal","typeDesc","cdDept","cdCommune","cdVoie","noVoirie","indRep", "voie","departement","commune","cdPrefix","cdSection","noPlan","noBatiment","noEscalier","noEtage","noPorte"]),
        ("Nature", ["lots","cdNature","cdConstParticuliere","nbPiecesPpales","cdDescHab"]),
        ("Surface", ["surface","categorie","surfacePrincipale", "surfaceSecCouv","surfaceSecNonCouv","surfaceParkCouv","surfaceParkNonCouv"]),
        ("Droits", ["droits","indivision","noPermis","identifiantProvisoire", "spi_delegataire","siren_delegataire"])
        ]
    
    static func label(for key: String) -> String {
        let labels: [String: String] = ["invariant":"invariant",
            "typeLocal":"type local",
            "typeDesc":"type description",
            "cdDept":"code département",
            "cdCommune":"code commune",
            "cdVoie":"code voie",
            "noVoirie":"n° voie",
            "indRep":"ind rep",
            "voie":"nom voie",
            "departement":"département",
            "commune":"commune",
            "cdPrefix":"préfixe",
            "cdSection":"section",
            "noPlan": "n° plan",
            "noBatiment":"n° bâtiment",
            "noEscalier":"escalier",
            "noEtage":"étage"
            ,"noPorte":"porte",
            "lots":"lots",
            "cdNature":"nature",
            "cdConstParticuliere": "construction particulière",
            "nbPiecesPpales" : "pièces principales",
            "cdDescHab":"code habitat",
            "surface":"surface",
            "categorie":"catégorie",
            "surfacePrincipale":"surface principale",
            "surfaceSecCouv":"surface secondaire couverte",
            "surfaceSecNonCouv":"surface secondaire non couverte",
            "surfaceParkCouv":"surface parking couverte",
            "surfaceParkNonCouv":"surface parking non couverte",
            "droits":"droit",
            "indivision":"indivision",
            "noPermis":"n° permis",
            "identifiantProvisoire":"id provisoire",
            "spi_delegataire":"SPI délégataire",
            "siren_delegataire":"SIREN délégataire"]
        return labels[key] ?? key
    }
}
