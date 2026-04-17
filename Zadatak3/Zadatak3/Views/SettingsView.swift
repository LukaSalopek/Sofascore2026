//
//  SettingsView.swift
//  Zadatak3
//
//  Created by akademija on 29.03.2026..
//

import UIKit
import SnapKit
import SofaAcademic

class SettingsView : BaseView {
    
    private var backIcon = UIImageView()
    private var settingsTitle = UILabel()
    var onBackTap : (() -> Void)?
    
    override func addViews(){
        addSubview(backIcon)
        addSubview(settingsTitle)
    }
    
    override func styleViews(){
        backIcon.image = UIImage(named: "back")
        backIcon.tintColor = .white
        
        settingsTitle.text = "Settings"
        settingsTitle.textColor = .white
        settingsTitle.font = .systemFont(ofSize: settingsTitle.font.pointSize, weight: .bold)
        
    }
    
    override func setupConstraints(){
        backIcon.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(12)
            $0.size.equalTo(24)
        }
        
        settingsTitle.snp.makeConstraints{
            $0.leading.equalTo(backIcon.snp.trailing).offset(32)
            $0.centerY.equalTo(backIcon)
            $0.height.equalTo(28)
            $0.trailing.lessThanOrEqualToSuperview().offset(16)
        }
    }
    
    override func setupGestureRecognizers(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(backTap))
        backIcon.addGestureRecognizer(tap)
        backIcon.isUserInteractionEnabled = true
    }
    
    @objc func backTap(){
        onBackTap?()
    }
    
}
