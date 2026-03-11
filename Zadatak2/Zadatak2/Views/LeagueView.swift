//
//  MatchView.swift
//  Zadatak2
//
//  Created by akademija on 10.03.2026..
//

import SofaAcademic
import UIKit
import SnapKit

class LeagueView : BaseView {
    
    
    private var leagueLogo = UIImageView()
    private var countryName = UILabel()
    private var leagueName = UILabel()
    
        override func addViews() {
            addSubview(leagueLogo)
            addSubview(countryName)
            addSubview(leagueName)
        }

        override func styleViews() {
            countryName.font = .systemFont(ofSize: 14)
            countryName.textColor = .black
            
            leagueName.font = .systemFont(ofSize: 14)
            leagueName.textColor = .gray
        }

        override func setupConstraints() {
            leagueLogo.snp.makeConstraints{
                $0.size.equalTo(32)
                $0.leading.equalToSuperview().offset(16)
                $0.top.equalToSuperview().offset(12)
            }
            
            countryName.snp.makeConstraints{
                $0.leading.equalToSuperview().offset(80)
                $0.top.equalToSuperview().offset(16)
            }
            
            leagueName.snp.makeConstraints{
                $0.leading.equalTo(countryName)
                $0.top.equalToSuperview().offset(16)
            }
            
            
        }

        override func setupGestureRecognizers() {
            // Configure gesture recognizers
        }

        override func setupBinding() {
            // Set up bindings
        }
    
    func configure(
        leagueLogo : UIImage,
        countryName : String,
        leagueName : String
    ) {
        self.leagueLogo.image = leagueLogo
        self.countryName.text=countryName
        self.leagueName.text=leagueName
    }
    
}
