//
//  AppStyles.swift
//  Zadatak3
//
//  Created by akademija on 18.03.2026..
//

import UIKit

extension UIColor {
    static let sofaGray = UIColor.gray
    static let sofaLightGray = UIColor.lightGray
    static let sofaSeparator = UIColor.lightGray
    static let sofaLiveRed = UIColor.red
    static let sofaTextBlack = UIColor.black
    static let sofaBlue = UIColor(red: 55/255, green: 77/255, blue: 245/255, alpha: 1.0)
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
