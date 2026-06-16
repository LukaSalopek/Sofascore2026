//
//  Event.swift
//  Zadatak3
//
//  Created by akademija on 08.05.2026..
//

public struct Event: Codable {
    public let id: Int
    public let homeTeam: Team
    public let awayTeam: Team
    public let startTimestamp: Int
    public let status: EventStatus
    public let league: League?
    public let homeScore: Int?
    public let awayScore: Int?
    public let round: Int?
    public let incidents: [Incident]?
}
