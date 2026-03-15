//
//  MatchView.swift
//  Zadatak2
//
//  Created by akademija on 10.03.2026..
//

import SofaAcademic
import UIKit
import SnapKit

class LeagueView: BaseView {
    
    private var leagueLogo = UIImageView()
    private var countryName = UILabel()
    private var littleIcon = UIImageView()
    private var leagueName = UILabel()
    
    override func addViews() {
        addSubview(leagueLogo)
        addSubview(countryName)
        addSubview(littleIcon)
        addSubview(leagueName)
    }

    override func styleViews() {
        countryName.font = .sofaLeagueCountry
        countryName.textColor = .sofaTextBlack
        
        leagueName.font = .sofaLeagueName
        leagueName.textColor = .sofaGray
        
        littleIcon.image = UIImage(systemName: AppStrings.iconPlay)
        littleIcon.tintColor = .sofaGray
    }

    override func setupConstraints() {
        leagueLogo.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-12)
        }
        
        countryName.snp.makeConstraints {
            $0.leading.equalTo(leagueLogo.snp.trailing).offset(12)
            $0.centerY.equalTo(leagueLogo)
        }
        
        littleIcon.snp.makeConstraints {
            $0.leading.equalTo(countryName.snp.trailing).offset(4)
            $0.centerY.equalTo(countryName)
            $0.height.equalTo(14)
            $0.width.equalTo(5)
        }
        
        leagueName.snp.makeConstraints {
            $0.leading.equalTo(littleIcon.snp.trailing).offset(4)
            $0.centerY.equalTo(countryName)
        }
    }
    
    func configure(leagueLogo: String, countryName: String, leagueName: String) {
        self.leagueLogo.image = UIImage(named: leagueLogo)
        self.countryName.text = countryName
        self.leagueName.text = leagueName
    }
}
