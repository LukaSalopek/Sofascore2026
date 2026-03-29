//
//  EventDetailsView.swift
//  Zadatak3
//
//  Created by akademija on 29.03.2026..
//

import UIKit
import SnapKit
import SofaAcademic

class EventDetailsView : BaseView {
    
    private var homeTeamLogo = UIImageView()
    private var awayTeamLogo = UIImageView()
    
    private var homeTeamName = UILabel()
    private var awayTeamName = UILabel()
    
    private var matchDate = UILabel()
    private var matchTime = UILabel()
    
    private var homeTeamScore = UILabel()
    private var awayTeamScore = UILabel()
    
    private var matchMinute = UILabel()
    
    
    override func addViews(){
        addSubview(homeTeamLogo)
        addSubview(awayTeamLogo)
        
        addSubview(homeTeamName)
        addSubview(awayTeamName)
        
        addSubview(matchDate)
        addSubview(matchTime)
        
        addSubview(homeTeamScore)
        addSubview(awayTeamScore)
        
        addSubview(matchMinute)
    }
    
    override func styleViews(){
        
        
    }
    
    override func setupConstraints(){
        
    }
}
