//
//  LeagueDetailsMapper.swift
//  Zadatak3
//

import Foundation

enum LeagueDetailsMapper {

    static func groupByRound(matches: [Event]) -> [RoundSection] {
        let grouped = Dictionary(grouping: matches, by: { $0.round ?? 0 })

        return grouped
            .map { round, events in
                RoundSection(
                    round: round,
                    events: events.sorted { $0.startTimestamp < $1.startTimestamp }
                )
            }
            .sorted { $0.round < $1.round }
    }

    static func sortStandings(_ standings: [Standings]) -> [Standings] {
        standings.sorted { $0.position < $1.position }
    }
}
