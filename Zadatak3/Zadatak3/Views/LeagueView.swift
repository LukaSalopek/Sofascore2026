//
//  LeagueView.swift
//  Zadatak3
//
//  Created by akademija on 18.03.2026..
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
        countryName.numberOfLines = 1
        countryName.lineBreakMode = .byTruncatingTail
        
        littleIcon.image = UIImage(systemName: AppStrings.iconPlay)
        littleIcon.tintColor = .sofaGray
        
        leagueName.font = .sofaLeagueName
        leagueName.textColor = .sofaGray
        leagueName.numberOfLines = 1
        leagueName.lineBreakMode = .byTruncatingTail
    }

    override func setupConstraints() {
        leagueLogo.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(12)
        }
        
        countryName.snp.makeConstraints {
            $0.leading.equalTo(leagueLogo.snp.trailing).offset(32)
            $0.top.bottom.equalToSuperview().inset(20)
        }
        
        littleIcon.snp.makeConstraints {
            $0.leading.equalTo(countryName.snp.trailing).offset(10)
            $0.height.equalTo(10)
            $0.width.equalTo(5)
            $0.top.bottom.equalToSuperview().inset(23)
        }
        
        leagueName.snp.makeConstraints {
            $0.leading.equalTo(littleIcon.snp.trailing).offset(9)
            $0.top.bottom.equalToSuperview().inset(20)
            $0.trailing.lessThanOrEqualToSuperview().inset(129)
        }
    }
    
    func configure(leagueLogo: String, countryName: String, leagueName: String) {
        self.leagueLogo.image = UIImage(named: leagueLogo)
        self.countryName.text = countryName
        self.leagueName.text = leagueName
    }
}
