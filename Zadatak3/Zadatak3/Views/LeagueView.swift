//
//  LeagueView.swift
//  Zadatak3
//

import SofaAcademic
import UIKit
import SnapKit

class LeagueView: BaseView {
    
    private let leagueLogo = UIImageView()
    private let countryName = UILabel()
    private let littleIcon = UIImageView()
    private let leagueName = UILabel()
    
    override func addViews() {
        addSubview(leagueLogo)
        addSubview(countryName)
        addSubview(littleIcon)
        addSubview(leagueName)
    }

    override func styleViews() {
        leagueLogo.contentMode = .scaleAspectFit
        
        countryName.font = .sofaLeagueCountry
        countryName.textColor = .sofaTextBlack
        countryName.numberOfLines = 1
        countryName.lineBreakMode = .byTruncatingTail
        
        littleIcon.image = UIImage(named: "Vector")
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
            $0.leading.equalTo(leagueLogo.snp.trailing).offset(12)
            $0.centerY.equalTo(leagueLogo.snp.centerY)
        }
        
        littleIcon.snp.makeConstraints {
            $0.leading.equalTo(countryName.snp.trailing).offset(10)
            $0.height.equalTo(10)
            $0.width.equalTo(5)
            $0.centerY.equalTo(leagueLogo.snp.centerY)
        }
        
        leagueName.snp.makeConstraints {
            $0.leading.equalTo(littleIcon.snp.trailing).offset(9)
            $0.centerY.equalTo(leagueLogo.snp.centerY)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }
    }
    
    func configure(
        countryName: String,
        leagueName: String,
        leagueLogo: UIImage
    ) {
        self.leagueLogo.image = leagueLogo
        self.countryName.text = countryName
        self.leagueName.text = leagueName
    }
}
