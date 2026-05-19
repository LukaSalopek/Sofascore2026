//
//  Standings.swift
//  Zadatak3
//
//  Created by akademija on 08.05.2026..
//

public struct Standings: Codable {
    public let team: Team
    public let position: Int
    public let matches: Int
    public let wins: Int
    public let losses: Int
    public let draws: Int
    public let points: Int
    public let percentage: Double?
    public let scoreFor: Int?
    public let scoreAgainst: Int?
    public let scoreFormatted: String?
}
