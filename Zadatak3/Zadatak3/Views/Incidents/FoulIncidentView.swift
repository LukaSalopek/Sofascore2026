//
//  FoulIncidentView.swift
//  Zadatak3
//
//  Created by akademija on 08.06.2026..
//

import SofaAcademic
import UIKit
import SnapKit

enum Side { case home, away}

class FoulIncidentView : BaseView {
    
    private let incidentImage = UIImageView()
    private let incidentMinute = UILabel()
    private let separatarLine = UIView()
    private let playerName = UILabel()
    private let incidentType = UILabel()
    
    override func addViews() {
        addSubview(incidentImage)
        addSubview(incidentMinute)
        addSubview(separatarLine)
        addSubview(playerName)
        addSubview(incidentType)
    }
    
    override func styleViews() {
        incidentMinute.textColor = .sofaGray
        incidentMinute.textAlignment = .center
        incidentMinute.font = .systemFont(ofSize: 12)
        
        separatarLine.backgroundColor = .sofaSeparator
        
        playerName.font = .sofaTeamName
        playerName.numberOfLines = 1
        playerName.lineBreakMode = .byTruncatingTail
        playerName.textColor = .sofaTextBlack
        
        incidentType.font = .sofaTeamName
        incidentType.numberOfLines = 1
        incidentType.lineBreakMode = .byTruncatingTail
        incidentType.textColor = .sofaGray
    }
    
    override func setupConstraints() {
        incidentImage.snp.makeConstraints{
            $0.size.equalTo(24)
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(16)
        }
        
        incidentMinute.snp.makeConstraints{
            $0.top.equalTo(incidentImage.snp.bottom)
            $0.centerX.equalTo(incidentImage)
            $0.width.equalTo(40)
            $0.height.equalTo(16)
            $0.bottom.equalToSuperview().inset(8)
        }
        
        separatarLine.snp.makeConstraints{
            $0.width.equalTo(1)
            $0.height.equalTo(40)
            $0.leading.equalTo(incidentMinute.snp.trailing).offset(7)
            $0.top.bottom.equalToSuperview().inset(8)
        }
        
        playerName.snp.makeConstraints{
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalTo(separatarLine.snp.trailing).offset(12)
            $0.height.equalTo(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
            $0.height.equalTo(16)
        }
        
        incidentType.snp.makeConstraints{
            $0.top.equalTo(playerName.snp.bottom)
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalTo(separatarLine.snp.trailing).offset(12)
            $0.height.equalTo(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }
    }
    
    func setSide(_ side : Side){
        semanticContentAttribute = (side == .home) ? .forceLeftToRight : .forceRightToLeft
        playerName.textAlignment = .natural
        incidentType.textAlignment = .natural
    }
    
    func setImage(image : UIImage) {
        self.incidentImage.image = image
    }
    
    func setPlayerName(playerName name : String) {
        self.playerName.text = name
    }
    
    func setIncidentType(incidentType type : String) {
        self.incidentType.text = type
    }
    
    func setIncidentMinute(minute incidentMinute : String){
        self.incidentMinute.text = incidentMinute
    }
    
}
