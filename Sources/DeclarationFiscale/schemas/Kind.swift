//
//  Kind.swift
//  DeclarationFiscale
//
//  Created by Herve Crespel on 29/09/2026.
//

public enum KindOfDeclaration: String {
    case occupation     = "occupation"
    case bien           = "bien"
    case unknown        = "inconnu"
    
    var titre: String {
        switch self {
        case .bien : "déclaration de bien"
        case .occupation : "déclaration d'occupation de bien"
        case .unknown : "déclaration inconnue"
        }
    }
    var filename: String {
        switch self {
        case .bien : "declarationbien"
        case .occupation : "declarationoccupation"
        case .unknown : "declarationinconnue"
        }
    }
}
