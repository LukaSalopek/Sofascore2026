//
//  Untitled.swift
//  Zadatak3
//
//  Created by akademija on 11.04.2026..
//

import UIKit
import SofaAcademic

class EventDetailsMapper {
    
    static func map(match: Event) -> EventDetailsDisplayModel {
        let state: EventDetailsDisplayModel.State
        
        switch match.status {
        case .inProgress:
            state = .live(
                homeScore: "\(match.homeTeamScore)",
                awayScore: "\(match.awayTeamScore)",
                minute: "\(match.timeDifference)'"
            )
            
        case .notStarted:
            let interval = TimeInterval(match.startTimestamp)
            let date = SofaDateFormatter.shared.dateFormat(interval: interval)
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "dd.MM.yyyy."
            
            state = .upcoming(
                date: dayFormatter.string(from: date),
                time: SofaDateFormatter.shared.formatter(interval: interval)
            )
            
        case .finished:
            let colors = ViewControllerHelper.getTeamColors(homeScore: match.homeTeamScore, awayScore: match.awayTeamScore)
            state = .finished(
                homeScore: "\(match.homeTeamScore)",
                awayScore: "\(match.awayTeamScore)",
                homeScoreColor: colors.home,
                awayScoreColor: colors.away
            )
            
        case .halftime:
            state = .halftime(
                homeScore: "\(match.homeTeamScore)",
                awayScore: "\(match.awayTeamScore)"
            )
        }
        
        return EventDetailsDisplayModel(
            homeTeamName: match.homeTeam.name,
            awayTeamName: match.awayTeam.name,
            homeTeamLogo: match.homeTeamLogo,
            awayTeamLogo: match.awayTeamLogo,
            state: state
        )
    }
}
