//
//  TeamVenue.swift
//  Zadatak3
//
//  Created by akademija on 08.05.2026..
//

public struct TeamVenue: Codable {
    public let name: String
    public let capacity: Int
    public let city: TeamVenueCity
    
    public init(name: String, capacity: Int, city: TeamVenueCity) {
        self.name = name
        self.capacity = capacity
        self.city = city
    }
}
