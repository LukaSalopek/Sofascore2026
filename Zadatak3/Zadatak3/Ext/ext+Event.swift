//
//  ext+Event.swift
//  Zadatak3
//
//  Created by akademija on 18.03.2026..
//

import SofaAcademic
import UIKit

extension Event {

    var homeTeamScore: Int {
        homeScore ?? 0
    }

    var awayTeamScore: Int {
        awayScore ?? 0
    }

    var formattedStartTime: String {

        SofaDateFormatter.shared.formatter(
            interval: TimeInterval(startTimestamp)
        )
    }

    var timeDifference: Int {

        let date = SofaDateFormatter.shared.dateFormat(
            interval: TimeInterval(startTimestamp)
        )

        return Int(Date().timeIntervalSince(date) / 60)
    }
}
