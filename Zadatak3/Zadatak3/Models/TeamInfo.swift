//
//  TeamInfo.swift
//  Zadatak3
//
//  Created by akademija on 08.05.2026..
//

public struct TeamInfo: Codable {
    public let team: Team
    public let manager: TeamManager?
    public let venue: TeamVenue?
    
    public init(team: Team, manager: TeamManager?, venue: TeamVenue?) {
        self.team = team
        self.manager = manager
        self.venue = venue
    }
}
