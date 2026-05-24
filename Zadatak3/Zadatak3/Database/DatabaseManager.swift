//
//  DatabaseManager.swift
//  Zadatak3
//
//  Created by akademija on 24.05.2026..
//

import GRDB
import Foundation

final class DatabaseManager {
    static let shared = DatabaseManager()
    private var dbQueue: DatabaseQueue?
    
    private init() {}
    
    func setup() throws {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let dbURL = paths[0].appendingPathComponent("appdb.sqlite")
        dbQueue = try DatabaseQueue(path: dbURL.path)
        
        try dbQueue?.write { db in
            try db.create(table: "leagues", ifNotExists: true) { t in
                t.column("id", .integer).primaryKey()
                t.column("name", .text).notNull()
                t.column("logoUrl", .text)
                t.column("countryName", .text)
            }
            
            try db.create(table: "events", ifNotExists: true) { t in
                t.column("id", .integer).primaryKey()
                t.column("homeTeamName", .text).notNull()
                t.column("awayTeamName", .text).notNull()
                t.column("startTimestamp", .integer).notNull()
                t.column("status", .text).notNull()
                t.column("homeScore", .integer).notNull()
                t.column("awayScore", .integer).notNull()
                t.column("homeTeamLogoUrl", .text)
                t.column("awayTeamLogoUrl", .text)
                t.column("leagueId", .integer).notNull()
                t.foreignKey(["leagueId"], references: "leagues", onDelete: .cascade)
            }
        }
    }
    
    func saveEventsAndLeagues(events: [Event]) throws {
        try dbQueue?.write { db in
            for event in events {
                if let league = event.league {
                    let leagueDB = LeagueDB(
                        id: league.id,
                        name: league.name,
                        logoUrl: league.logoUrl,
                        countryName: league.country?.name
                    )
                    try leagueDB.save(db)
                    
                    let eventDB = EventDB(
                        id: event.id,
                        homeTeamName: event.homeTeam.name,
                        awayTeamName: event.awayTeam.name,
                        startTimestamp: event.startTimestamp,
                        status: event.status.rawValue,
                        homeScore: event.homeTeamScore,
                        awayScore: event.awayTeamScore,
                        homeTeamLogoUrl: event.homeTeam.logoUrl,
                        awayTeamLogoUrl: event.awayTeam.logoUrl,
                        leagueId: league.id
                    )
                    try eventDB.save(db)
                }
            }
        }
    }
    
    func getEventCount() -> Int {
        return (try? dbQueue?.read { db in try EventDB.fetchCount(db) }) ?? 0
    }
    
    func getLeagueCount() -> Int {
        return (try? dbQueue?.read { db in try LeagueDB.fetchCount(db) }) ?? 0
    }
    
    func clearAll() throws {
        try dbQueue?.write { db in
            try EventDB.deleteAll(db)
            try LeagueDB.deleteAll(db)
        }
    }
}
