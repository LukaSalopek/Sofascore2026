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

    func getGroupedEvents() -> [Section] {
        let allEvents = Homework3DataSource().events()

        let grouped = Dictionary(grouping: allEvents, by: { $0.league?.id ?? 0 })

        let sections = grouped.compactMap { (key, events) -> Section? in
            guard let firstLeague = events.first?.league else { return nil }
            
            let sortedEventsForLeague = events.sorted(by: { $0.startTimestamp < $1.startTimestamp })
            
            return Section(league: firstLeague, events: sortedEventsForLeague)
        }

        return sections.sorted(by: { $0.league.name < $1.league.name })
    }
}
