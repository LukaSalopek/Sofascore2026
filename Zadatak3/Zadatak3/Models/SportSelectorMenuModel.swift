//
//  SportSelectorMenuModel.swift
//  Zadatak3
//
//  Created by akademija on 18.03.2026..
//


import UIKit

struct SportSelectorMenuModel {

    let id: Int
    let sportName: String
    let sportImage: UIImage
    let slug: String

    static let sportSelectorMenuData: [SportSelectorMenuModel] = [

        SportSelectorMenuModel(
            id: 1,
            sportName: "Football",
            sportImage: UIImage(named: "icon_football") ?? UIImage(),
            slug: "football"
        ),

        SportSelectorMenuModel(
            id: 2,
            sportName: "Basketball",
            sportImage: UIImage(named: "icon_basketball") ?? UIImage(),
            slug: "basketball"
        ),

        SportSelectorMenuModel(
            id: 3,
            sportName: "Am. Football",
            sportImage: UIImage(named: "icon_american_football") ?? UIImage(),
            slug: "am-football"
        )
    ]
}

