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
    
    public init(team: Team, position: Int, matches: Int, wins: Int, losses: Int, draws: Int, points: Int, percentage: Double?, scoreFor: Int?, scoreAgainst: Int?, scoreFormatted: String?) {
        self.team = team
        self.position = position
        self.matches = matches
        self.wins = wins
        self.losses = losses
        self.draws = draws
        self.points = points
        self.percentage = percentage
        self.scoreFor = scoreFor
        self.scoreAgainst = scoreAgainst
        self.scoreFormatted = scoreFormatted
    }
}
