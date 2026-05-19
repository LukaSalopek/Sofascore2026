//
//  Incident.swift
//  Zadatak3
//
//  Created by akademija on 08.05.2026..
//

public struct Incident: Codable {
    public let type: String
    public let minute: Int?
    public let isHomeTeam: Bool
    public let extraMinute: Int?
    public let player: String?
    public let scoreDiff: Int?
    public let score: String?
    public let description: String?
}
