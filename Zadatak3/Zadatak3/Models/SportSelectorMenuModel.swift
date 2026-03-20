//
//  SportSelectorMenuModel.swift
//  Zadatak3
//
//  Created by akademija on 18.03.2026..
//


import UIKit

struct SportSelectorMenuModel {
    var sportName : String
    var sportImage : UIImage
}


var SportSelectorMenuData : [SportSelectorMenuModel] = [
    SportSelectorMenuModel(sportName: "Football", sportImage: UIImage(named: "icon_football") ?? UIImage()),
    SportSelectorMenuModel(sportName: "Basketball", sportImage: UIImage(named: "icon_basketball") ?? UIImage()),
    SportSelectorMenuModel(sportName: "Am. Football", sportImage: UIImage(named: "icon_american_football") ?? UIImage())
                           
]
