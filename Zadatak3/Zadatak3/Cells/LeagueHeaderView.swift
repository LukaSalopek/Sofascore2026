//
//  LeagueHeaderView.swift
//  Zadatak3
//
//  Created by akademija on 22.03.2026..
//

import UIKit
import SnapKit

class LeagueHeaderView: UITableViewHeaderFooterView {
    let leagueView = LeagueView()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(leagueView)
        leagueView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    required init?(coder: NSCoder) { fatalError() }
}
