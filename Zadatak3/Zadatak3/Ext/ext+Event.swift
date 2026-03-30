//
//  ext+Event.swift
//  Zadatak3
//
//  Created by akademija on 18.03.2026..
//

import SofaAcademic
import UIKit

extension Event {
    
    var homeTeamScore : Int {
        return self.homeScore ?? 0
    }
    var awayTeamScore : Int {
        return self.awayScore ?? 0
    }
    
    var homeTeamLogo: UIImage {
        return UIImage(named: self.homeTeam.name.toCamelCase()) ?? UIImage()
    }
    
    var awayTeamLogo: UIImage {
        return UIImage(named: self.awayTeam.name.toCamelCase()) ?? UIImage()
    }
    
    var formattedStartTime: String {
        return SofaDateFormatter.shared.formatter(interval: TimeInterval(self.startTimestamp))
    }
    
    var timeDifference: Int {
        let date = SofaDateFormatter.shared.dateFormat(interval: TimeInterval(self.startTimestamp))
        let diff = Int(Date().timeIntervalSince(date) / 60)
        return diff
    }
}
