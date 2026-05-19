//
//  EventDetailsDisplayModel.swift
//  Zadatak3
//
//  Created by akademija on 11.04.2026..
//

import UIKit

struct EventDetailsDisplayModel {
    let homeTeamName: String
    let awayTeamName: String
    let homeTeamLogoURL: String?
    let awayTeamLogoURL: String?
    let state: State

    enum State {
        case upcoming(date: String, time: String)
        case live(homeScore: String, awayScore: String, minute: String)
        case halftime(homeScore: String, awayScore: String)
        case finished(homeScore: String, awayScore: String, homeScoreColor: UIColor, awayScoreColor: UIColor)
    }
}
