//
//  SportSelectorMenuCell.swift
//  Zadatak3
//
//  Created by akademija on 18.03.2026..
//

import SnapKit
import UIKit
import SofaAcademic

class SportSelectorMenuCell : BaseView {
    
    private var sportIcon = UIImageView()
    private var sportName = UILabel()
    var onSelected: (() -> Void)?
    
    
    override func addViews() {
        addSubview(sportIcon)
        addSubview(sportName)
    }
    
    override func styleViews(){
        
        sportIcon.tintColor = .white
        
        sportName.textColor = .white
        sportName.font = .systemFont(ofSize: 14)
        sportName.textAlignment = .center
        sportName.numberOfLines = 1
        sportName.lineBreakMode = .byTruncatingTail
        
    }
    
    override func setupConstraints(){
        
        sportIcon.snp.makeConstraints{
            $0.top.equalToSuperview().inset(4)
            $0.size.equalTo(16)
            $0.centerX.equalToSuperview()
        }
        
        sportName.snp.makeConstraints{
            $0.top.equalTo(sportIcon.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    override func setupGestureRecognizers(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func handleTap(){
        onSelected?()
    }
    
    func setSports(sportName : String, sportImage : UIImage) {
        self.sportName.text = sportName
        self.sportIcon.image = sportImage.withRenderingMode(.alwaysTemplate)
    }
    
    
    
    
}
