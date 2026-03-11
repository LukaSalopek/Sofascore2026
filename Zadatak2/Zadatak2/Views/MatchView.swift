//
//  CustomView.swift
//  Zadatak2
//
//  Created by akademija on 10.03.2026..
//

import SofaAcademic
import UIKit
import SnapKit

class MatchView: BaseView {
    
    private var matchTime = UILabel()
    private var matchMinute = UILabel()

    private var homeTeamName = UILabel()
    private var awayTeamName = UILabel()
    
    private var homeTeamScore = UILabel()
    private var awayTeamScore = UILabel()
    
    private var homeTeamLogo = UIImageView()
    private var awayTeamLogo = UIImageView()
    
    override func addViews() {
        addSubview(matchTime)
        addSubview(homeTeamName)
        addSubview(awayTeamName)
        addSubview(homeTeamScore)
        addSubview(awayTeamScore)
        addSubview(homeTeamLogo)
        addSubview(awayTeamLogo)
    }

    override func styleViews() {
        matchTime.font = .systemFont(ofSize: 12)
        matchTime.textColor = .gray
        
        homeTeamName.font = .systemFont(ofSize: 14, weight: .regular)
        awayTeamName.font = .systemFont(ofSize: 14, weight: .regular)
        
        homeTeamScore.font = .systemFont(ofSize: 14, weight: .regular)
        awayTeamScore.font = .systemFont(ofSize: 14, weight: .regular)
        
        //test
        
        matchTime.text="12"
        homeTeamName.text="Real Madrid"
        homeTeamScore.text="1"
        
        awayTeamName.text="Barcelona"
        awayTeamScore.text="0"
        
    
        
    }

    override func setupConstraints() {
        matchTime.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalTo(64)
        }
        
        homeTeamLogo.snp.makeConstraints{
            $0.size.equalTo(16)
            $0.leading.equalTo(matchTime.snp.trailing).offset(8)
            $0.centerY.equalToSuperview().offset(8)
        }
        
        homeTeamName.snp.makeConstraints{
            $0.leading.equalTo(homeTeamLogo).offset(8)
            $0.top.equalToSuperview()
        }
        
        awayTeamLogo.snp.makeConstraints{
            $0.leading.equalTo(matchTime.snp.trailing).offset(8)
            $0.bottom.equalToSuperview().offset(8)
        }
        
        awayTeamName.snp.makeConstraints{
            $0.leading.equalTo(awayTeamLogo).offset(8)
            $0.bottom.equalToSuperview()
        }
        
        
        homeTeamScore.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        awayTeamScore.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    override func setupGestureRecognizers() {
        // Configure gesture recognizers
    }

    override func setupBinding() {
        // Set up bindings
    }
    
    func configure(
        matchTime : String,
        matchMinute : String,
        matchStatus : UIColor,
        homeTeamName : String,
        awayTeamName : String,
        homeTeamLogo : String,
        awayTeamLogo : String,
        homeTeamScore : String,
        awayTeamScore : String,
        homeTeamColor : UIColor,
        awayTeamColor : UIColor
    ){
        
    }
}

#Preview {
    LeagueView()
}
