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

            let sortedEventsForLeague = events.sorted { event1, event2 in
                let priority1 = self.priority(for: event1.status)
                let priority2 = self.priority(for: event2.status)

                if priority1 != priority2 {
                    return priority1 < priority2
                }
                
                if event1.status == .finished {
                    return event1.startTimestamp > event2.startTimestamp
                } else {
                    return event1.startTimestamp < event2.startTimestamp
                }
            }
            
            return Section(league: firstLeague, events: sortedEventsForLeague)
        }

        return sections.sorted(by: { $0.league.name < $1.league.name })
    }

    private func priority(for status: EventStatus) -> Int {
        switch status {
        case .finished:
            return 1
        case .inProgress, .halftime:
            return 2
        case .notStarted:
            return 3
        }
    }
}
