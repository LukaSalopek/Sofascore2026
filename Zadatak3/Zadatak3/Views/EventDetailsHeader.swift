//
//  EventDetailsHeader.swift
//  Zadatak3
//
//  Created by akademija on 31.03.2026..
//


import UIKit
import SofaAcademic
import SnapKit

class EventDetailsHeader : BaseView {
    
    private var backButton = UIImageView()
    private var leagueLogo = UIImageView()
    private var infoLabel = UILabel()
    
    var isBackTapped: (() -> Void)?
    
    
    override func addViews() {
        addSubview(backButton)
        addSubview(leagueLogo)
        addSubview(infoLabel)
    }
 
    override func styleViews() {
        let backImage = UIImage(named: "back")?.withRenderingMode(.alwaysTemplate)
        backButton.image = backImage
        backButton.tintColor = .black
        infoLabel.textColor = .sofaGray
        infoLabel.font = .systemFont(ofSize: 12)
        infoLabel.numberOfLines = 1
        infoLabel.lineBreakMode = .byTruncatingTail
        
    }
    
    override func setupConstraints() {
        backButton.snp.makeConstraints{
            $0.size.equalTo(24)
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(12)
        }
        
        leagueLogo.snp.makeConstraints{
            $0.size.equalTo(24)
            $0.leading.equalTo(backButton.snp.trailing).offset(24)
            $0.centerY.equalTo(backButton)
        }
        
        infoLabel.snp.makeConstraints{
            $0.leading.equalTo(leagueLogo.snp.trailing).offset(8)
            $0.centerY.equalTo(backButton)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }
    }
    
    override func setupGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backTapped))
        backButton.addGestureRecognizer(tap)
        backButton.isUserInteractionEnabled = true
    }
    
    @objc func backTapped(){
        isBackTapped?()
    }
    
}
