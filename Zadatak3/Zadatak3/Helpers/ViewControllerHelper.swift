//
//  ViewControllerHelper.swift
//  Zadatak2
//
//  Created by akademija on 20.03.2026..
//

import UIKit

struct TeamColors {
    let home: UIColor
    let away: UIColor
}

enum ViewControllerHelper {
    
    static func getTeamColors(homeScore: Int, awayScore: Int) -> TeamColors {
        if homeScore > awayScore {
            return TeamColors(home: .sofaTextBlack, away: .sofaGray)
        } else if awayScore > homeScore {
            return TeamColors(home: .sofaGray, away: .sofaTextBlack)
        } else {
            return TeamColors(home: .sofaGray, away: .sofaGray)
        }
    }
}
