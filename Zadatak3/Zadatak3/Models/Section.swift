//
//  Section.swift
//  Zadatak3
//
//  Created by akademija on 22.03.2026..
//


import Foundation
import SofaAcademic

struct Section {
    let league: League
    let events: [Event]
}

final class EventService {

    private let allEvents = Homework3DataSource().events()

    func getGroupedEvents() -> [Section] {
        let grouped = Dictionary(grouping: allEvents, by: { $0.league?.id ?? 0 })

        let sections = grouped.compactMap { (key, events) -> Section? in
            guard let firstLeague = events.first?.league else { return nil }

            let sortedEventsForLeague = events.sorted {
                if $0.status == .inProgress && $1.status != .inProgress { return true }
                if $0.status != .inProgress && $1.status == .inProgress { return false }
                return $0.startTimestamp < $1.startTimestamp
            }
            
            return Section(league: firstLeague, events: sortedEventsForLeague)
        }

        return sections.sorted(by: { $0.league.name < $1.league.name })
    }
}
