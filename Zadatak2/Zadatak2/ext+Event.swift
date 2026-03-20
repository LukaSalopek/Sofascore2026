//
//  ext+Event.swift
//  Zadatak2
//
//  Created by akademija on 17.03.2026..
//

import SofaAcademic
import UIKit

extension Event {
    
    var getHomeTeamScore : Int {
        return self.homeScore ?? 0
    }
    var getAwayTeamScore : Int {
        return self.awayScore ?? 0
    }
    
    var homeTeamLogo: UIImage {
        return UIImage(named: self.homeTeam.name) ?? UIImage()
    }
    
    var awayTeamLogo: UIImage {
        return UIImage(named: self.awayTeam.name) ?? UIImage()
    }
    
    var dataFormat: String {
        return SofaDateFormatter.shared.formatter(interval: TimeInterval(self.startTimestamp))
    }
    
    var timeDifference: Int {
        let date = SofaDateFormatter.shared.dateFormat(interval: TimeInterval(self.startTimestamp))
        let diff = Int(Date().timeIntervalSince(date) / 60)
        return diff
    }
}
