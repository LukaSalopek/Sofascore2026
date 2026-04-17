//
//  HeaderView.swift
//  Zadatak3
//
//  Created by akademija on 29.03.2026..
//

import SofaAcademic
import SnapKit
import UIKit


class HeaderView : BaseView {
    
    var onSettingsTap: (() -> Void)?
    
    private let sofascoreLogo = UIImageView()
    private let trophyImage = UIImageView()
    private let settingsImage = UIImageView()
    
    override func addViews(){
        addSubview(sofascoreLogo)
        addSubview(trophyImage)
        addSubview(settingsImage)
    }
    
    override func styleViews(){
        sofascoreLogo.image = UIImage(named: "sofascoreLogo")
        sofascoreLogo.tintColor = .white
        
        trophyImage.image = UIImage(named: "trophy")
        trophyImage.tintColor = .white
        
        settingsImage.image = UIImage(named: "settings")
        settingsImage.tintColor = .white
        
    }
    
    override func setupConstraints(){
        sofascoreLogo.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(14)
            $0.height.equalTo(20)
            $0.width.equalTo(131.85)
        }
        
        trophyImage.snp.makeConstraints{
            $0.size.equalTo(48)
            $0.trailing.equalTo(settingsImage.snp.leading)
            $0.centerY.equalTo(sofascoreLogo)
        }
        
        settingsImage.snp.makeConstraints{
            $0.size.equalTo(48)
            $0.centerY.equalTo(sofascoreLogo)
            $0.trailing.equalToSuperview().inset(4)
        }
    }
    
    override func setupGestureRecognizers(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(settingsTapped))
        self.settingsImage.addGestureRecognizer(tap)
        self.settingsImage.isUserInteractionEnabled = true
    }
    
    @objc private func settingsTapped(){
        onSettingsTap?()
    }
    
}

