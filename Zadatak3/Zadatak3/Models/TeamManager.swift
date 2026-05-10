//
//  TeamManager.swift
//  Zadatak3
//
//  Created by akademija on 08.05.2026..
//

public struct TeamManager: Codable {
    public let id: Int
    public let name: String
    public let country: Country?
    public let imageUrl: String?
    
    public init(id: Int, name: String, country: Country?, imageUrl: String?) {
        self.id = id
        self.name = name
        self.country = country
        self.imageUrl = imageUrl
    }
}
