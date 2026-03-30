//
//  SportSelectorMenuModel.swift
//  Zadatak3
//
//  Created by akademija on 18.03.2026..
//


import UIKit

struct SportSelectorMenuModel {
    let id : Int
    var sportName : String
    var sportImage : UIImage
    
    static let sportSelectorMenuData : [SportSelectorMenuModel] = [
        SportSelectorMenuModel(id: 1, sportName: "Football", sportImage: UIImage(named: "icon_football") ?? UIImage()),
        SportSelectorMenuModel(id: 2, sportName: "Basketball", sportImage: UIImage(named: "icon_basketball") ?? UIImage()),
        SportSelectorMenuModel(id: 3, sportName: "Am. Football", sportImage: UIImage(named: "icon_american_football") ?? UIImage())
                               
    ]
}



