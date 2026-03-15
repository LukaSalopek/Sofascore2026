//
//  AppStyles.swift
//  Zadatak2
//
//  Created by akademija on 15.03.2026..
//

import UIKit

extension UIColor {
    static let sofaGray = UIColor.gray
    static let sofaLightGray = UIColor.lightGray
    static let sofaSeparator = UIColor.lightGray
    static let sofaLiveRed = UIColor.red
    static let sofaTextBlack = UIColor.black
}

extension UIFont {
    static let sofaTime = UIFont.systemFont(ofSize: 12)
    static let sofaTeamName = UIFont.systemFont(ofSize: 14, weight: .regular)
    static let sofaScore = UIFont.systemFont(ofSize: 14, weight: .regular)
    static let sofaLeagueCountry = UIFont.systemFont(ofSize: 14)
    static let sofaLeagueName = UIFont.systemFont(ofSize: 14)
}

enum AppStrings {
    static let finished = "FT"
    static let halftime = "HT"
    static let notStarted = "-"
    static let iconPlay = "play.fill"
}
