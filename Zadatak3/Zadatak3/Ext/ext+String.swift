//
//  ext+String.swift
//  Zadatak3
//
//  Created by akademija on 22.03.2026..
//

import Foundation

extension String {
    func toCamelCase() -> String {
        let components = self.components(separatedBy: CharacterSet.alphanumerics.inverted).filter { !$0.isEmpty }

        guard !components.isEmpty else { return self }
        
        let first = components[0].lowercased()
        let rest = components.dropFirst().map { $0.capitalized }
        
        return ([first] + rest).joined()
    }
}
