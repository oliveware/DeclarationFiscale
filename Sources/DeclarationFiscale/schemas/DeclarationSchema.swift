//
//  BienCSVSchema.swift
//  DeclarationOccupation
//
//  Created by Herve Crespel on 15/09/2026.
//

public struct DeclarationSchema {
    init (headers:[String], groups:[(String, [String])], labels:[String:String]) {
        self.headers = headers
        self.groups = groups
        self.labels = labels
    }
    
    init(_ kind:KindOfDeclaration) {
        switch kind {
        case .bien:         self = bienSchema
        case .occupation:   self = occupationSchema
        default: headers = [] ; groups = [] ; labels = [:]
        }
    }
    
    let headers: [String]
    let groups: [(String, [String])]
    let labels: [String: String]
    
    func label(for key: String) -> String {
        return labels[key] ?? key
    }
}
