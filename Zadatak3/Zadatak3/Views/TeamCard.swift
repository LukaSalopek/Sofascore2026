//
//  TeamCard.swift
//  Zadatak3
//
//  Created by akademija on 11.04.2026..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class TeamCard : BaseView{
    
    private var teamIcon = UIImageView()
    private var teamName = UILabel()

    override func addViews() {
        addSubview(teamIcon)
        addSubview(teamName)
    }
    
    override func styleViews(){
        teamIcon.contentMode = .scaleAspectFit
        
        teamName.font = .systemFont(ofSize: 12, weight: .bold)
        teamName.textColor = .sofaTextBlack
        teamName.numberOfLines = 2
        teamName.lineBreakMode = .byTruncatingTail
        teamName.textAlignment = .center
    }
    
    override func setupConstraints(){
        teamIcon.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.size.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        teamName.snp.makeConstraints{
            $0.top.equalTo(teamIcon.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.centerX.equalTo(teamIcon)
        }
    }
    
    func configure(teamName : String, image : UIImage){
        self.teamName.text = teamName
        self.teamIcon.image = image
    }

    func updateNameColor(color: UIColor) {
        self.teamName.textColor = color
    }
    func updateImage(image: UIImage) {
        teamIcon.image = image
    }
}
