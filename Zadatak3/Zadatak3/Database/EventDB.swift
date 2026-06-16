//
//  EventDB.swift
//  Zadatak3
//
//  Created by akademija on 24.05.2026..
//

import GRDB

struct EventDB: Codable, FetchableRecord, PersistableRecord {
    var id: Int
    var homeTeamName: String
    var awayTeamName: String
    var startTimestamp: Int
    var status: String
    var homeScore: Int
    var awayScore: Int
    var homeTeamLogoUrl: String?
    var awayTeamLogoUrl: String?
    var leagueId: Int
    
    enum Columns {
        static let id = Column(CodingKeys.id)
        static let leagueId = Column(CodingKeys.leagueId)
    }
    
    static let databaseTableName = "events"
}

struct LeagueDB: Codable, FetchableRecord, PersistableRecord {
    var id: Int
    var name: String
    var logoUrl: String?
    var countryName: String?
    
    static let databaseTableName = "leagues"
}
