//
//  ViewControllerHelper.swift
//  Zadatak2
//
//  Created by akademija on 20.03.2026..
//

import UIKit

struct ViewControllerHelper {
        
    func setTeamColors(homeTeamScore : Int, awayTeamScore : Int) -> [UIColor]{
        if homeTeamScore>awayTeamScore {
            return [.black, .sofaGray]
        } else if awayTeamScore > homeTeamScore {
            return [.sofaGray, .black]
        } else {
            return [.sofaGray, .sofaGray]
        }
    }
    
    
}

