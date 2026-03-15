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
    private var linija = UIView()
    
    override func addViews() {
        addSubview(matchTime)
        addSubview(matchMinute)
        addSubview(linija)
        addSubview(homeTeamName)
        addSubview(awayTeamName)
        addSubview(homeTeamScore)
        addSubview(awayTeamScore)
        addSubview(homeTeamLogo)
        addSubview(awayTeamLogo)
    }

    override func styleViews() {
        matchTime.font = .sofaTime
        matchTime.textColor = .sofaGray
        
        matchMinute.font = .sofaTime
        matchMinute.textColor = .sofaGray
        
        homeTeamName.font = .sofaTeamName
        awayTeamName.font = .sofaTeamName
        homeTeamName.numberOfLines = 2
        awayTeamName.numberOfLines = 2
        
        homeTeamScore.font = .sofaScore
        awayTeamScore.font = .sofaScore
        
        linija.backgroundColor = .sofaSeparator
    }

    override func setupConstraints() {
        matchTime.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.width.equalTo(45)
        }
        
        matchMinute.snp.makeConstraints {
            $0.top.equalTo(matchTime.snp.bottom).offset(5)
            $0.centerX.equalTo(matchTime.snp.centerX).offset(-7)
        }
        
        linija.snp.makeConstraints {
            $0.leading.equalTo(matchTime.snp.trailing)
            $0.height.equalToSuperview()
            $0.width.equalTo(0.5)
        }
        
        homeTeamLogo.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.leading.equalTo(matchTime.snp.trailing).offset(12)
            $0.top.equalToSuperview()
        }

        homeTeamName.snp.makeConstraints {
            $0.leading.equalTo(homeTeamLogo.snp.trailing).offset(8)
            $0.centerY.equalTo(homeTeamLogo)
            $0.trailing.lessThanOrEqualTo(homeTeamScore.snp.leading).offset(-8)
        }

        awayTeamLogo.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.leading.equalTo(homeTeamLogo)
            $0.bottom.equalToSuperview()
        }

        awayTeamName.snp.makeConstraints {
            $0.leading.equalTo(awayTeamLogo.snp.trailing).offset(8)
            $0.centerY.equalTo(awayTeamLogo)
            $0.trailing.lessThanOrEqualTo(awayTeamScore.snp.leading).offset(-8)
        }

        homeTeamScore.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }

        awayTeamScore.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func setMatch(firstName: String, secondName: String, matchTime: String) {
        self.homeTeamName.text = firstName
        self.awayTeamName.text = secondName
        self.matchTime.text = matchTime
    }
    
    func updateHomeLogo(firstLogo: String) {
        self.homeTeamLogo.image = UIImage(named: firstLogo)
    }
    
    func updateAwayLogo(secondLogo: String) {
        self.awayTeamLogo.image = UIImage(named: secondLogo)
    }
    
    func updateTime(time: String) {
        self.matchMinute.text = time
    }
    
    func updateScore(firstScore: Int, secondScore: Int) {
        self.homeTeamScore.text = String(firstScore)
        self.awayTeamScore.text = String(secondScore)
    }
    
    func isLive() {
        self.matchMinute.textColor = .sofaLiveRed
        self.homeTeamScore.textColor = .sofaLiveRed
        self.awayTeamScore.textColor = .sofaLiveRed
    }
    
    func firstWinner() {
        self.awayTeamName.textColor = .sofaGray
        self.awayTeamScore.textColor = .sofaGray
    }
    
    func secondWinner() {
        self.homeTeamName.textColor = .sofaGray
        self.homeTeamScore.textColor = .sofaGray
    }
    
    func draw() {
        firstWinner()
        secondWinner()
    }
}
