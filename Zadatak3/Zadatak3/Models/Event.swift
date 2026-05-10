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
    
    public init(
        id: Int,
        homeTeam: Team,
        awayTeam: Team,
        startTimestamp: Int,
        status: EventStatus,
        league: League,
        homeScore: Int? = nil,
        awayScore: Int? = nil,
        round: Int,
        incidents: [Incident]? = nil
    ) {
        self.id = id
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.startTimestamp = startTimestamp
        self.status = status
        self.league = league
        self.homeScore = homeScore
        self.awayScore = awayScore
        self.round = round
        self.incidents = incidents
    }
}
