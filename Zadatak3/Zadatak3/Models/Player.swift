//
//  Player.swift
//  Zadatak3
//
//  Created by akademija on 08.05.2026..
//

public struct Player: Codable {
    public let id: Int
    public let name: String
    public let shortName: String?
    public let position: String?
    public let jerseyNumber: String?
    public let country: Country?
    public let imageUrl: String?
    public let isForeign: Bool
    
    public init(id: Int, name: String, shortName: String?, position: String?, jerseyNumber: String?, country: Country?, imageUrl: String?, isForeign: Bool) {
        self.id = id
        self.name = name
        self.shortName = shortName
        self.position = position
        self.jerseyNumber = jerseyNumber
        self.country = country
        self.imageUrl = imageUrl
        self.isForeign = isForeign
    }
}
