//
//  RoundSection.swift
//  Zadatak3
//

import Foundation

struct RoundSection {
    let round: Int
    let events: [Event]
}

final class LeagueService {

    func getMatchesGroupedByRound(leagueId: Int) async throws -> [RoundSection] {
        let matches = try await APIClient.shared.fetchLeagueMatches(leagueId: leagueId)

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

    func getStandings(leagueId: Int) async throws -> [Standings] {
        let standings = try await APIClient.shared.fetchLeagueStandings(leagueId: leagueId)
        return standings.sorted { $0.position < $1.position }
    }
}
