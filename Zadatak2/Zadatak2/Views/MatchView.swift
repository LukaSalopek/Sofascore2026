//
//  MatchView.swift
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
    
    private var line = UIView()
    
    private var homeTeamLogo = UIImageView()
    private var awayTeamLogo = UIImageView()
    
    private var homeTeamName = UILabel()
    private var awayTeamName = UILabel()
    
    private var homeTeamScore = UILabel()
    private var awayTeamScore = UILabel()


    
    override func addViews() {
        addSubview(matchTime)
        addSubview(matchMinute)
        addSubview(line)
        addSubview(homeTeamLogo)
        addSubview(awayTeamLogo)
        addSubview(homeTeamName)
        addSubview(awayTeamName)
        addSubview(homeTeamScore)
        addSubview(awayTeamScore)
        
    }

    override func styleViews() {
        matchTime.font = .sofaTime
        matchTime.textColor = .sofaGray
        matchTime.textAlignment = .center
        
        matchMinute.font = .sofaTime
        matchMinute.textColor = .sofaGray
        matchMinute.textAlignment = .center
        
        line.backgroundColor = .sofaSeparator
        
        homeTeamName.font = .sofaTeamName
        homeTeamName.numberOfLines = 1
        homeTeamName.lineBreakMode = .byTruncatingTail
        
        awayTeamName.font = .sofaTeamName
        awayTeamName.numberOfLines = 1
        awayTeamName.lineBreakMode = .byTruncatingTail
        
        homeTeamScore.font = .sofaScore
        homeTeamScore.textAlignment = .right
        
        awayTeamScore.font = .sofaScore
        awayTeamScore.textAlignment = .right
    }

    override func setupConstraints() {
        matchTime.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(4)
            $0.width.equalTo(56)
            
        }
            
        matchMinute.snp.makeConstraints {
            $0.top.equalTo(matchTime.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(4)
            $0.width.equalTo(56)
        }
        
        line.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalTo(matchTime.snp.trailing).offset(3)
            $0.height.equalTo(40)
            $0.width.equalTo(1)
            
        }
        
        homeTeamLogo.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.leading.equalTo(line.snp.trailing).offset(16)
            $0.top.equalToSuperview().inset(10)
        }
        
        awayTeamLogo.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.leading.equalTo(line.snp.trailing).offset(16)
            $0.top.equalTo(homeTeamLogo.snp.bottom).offset(4)
        }

        homeTeamName.snp.makeConstraints {
            $0.leading.equalTo(homeTeamLogo.snp.trailing).offset(8)
            $0.top.equalToSuperview().inset(10)
            $0.trailing.lessThanOrEqualToSuperview().inset(64)
        }

        awayTeamName.snp.makeConstraints {
            $0.leading.equalTo(awayTeamLogo.snp.trailing).offset(8)
            $0.top.equalTo(homeTeamName.snp.bottom).offset(4)
            $0.trailing.lessThanOrEqualToSuperview().inset(64)
        }

        homeTeamScore.snp.makeConstraints {
            $0.leading.lessThanOrEqualToSuperview().inset(312)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(10)
        }

        awayTeamScore.snp.makeConstraints {
            $0.leading.lessThanOrEqualToSuperview().inset(312)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(homeTeamLogo.snp.bottom).offset(4)
        }
    }
    
    func setMatch(homeTeamName: String, awayTeamName: String, matchTime: String) {
        self.homeTeamName.text = homeTeamName
        self.awayTeamName.text = awayTeamName
        self.matchTime.text = matchTime
    }
    
    func updateHomeLogo(homeTeam: UIImage) {
        self.homeTeamLogo.image = homeTeam
    }
    
    func updateAwayLogo(awayTeam : UIImage) {
        self.awayTeamLogo.image = awayTeam
    }
    
    func updateTime(time: String) {
        self.matchMinute.text = time
    }
    
    func updateScore(homeScore: Int, awayScore: Int) {
        self.homeTeamScore.text = String(homeScore)
        self.awayTeamScore.text = String(awayScore)
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
