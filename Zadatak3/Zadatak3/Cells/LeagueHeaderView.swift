//
//  LeagueHeaderView.swift
//  Zadatak3
//
//  Created by akademija on 22.03.2026..
//

import UIKit
import SnapKit
import SofaAcademic

class LeagueHeaderView: UITableViewHeaderFooterView {
    private let leagueView = LeagueView()
    static let reuseIdentifier = "LeagueHeader"

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(leagueView)
        leagueView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(with league: League) {
            leagueView.configure(
                leagueLogo: league.name,
                countryName: league.country?.name ?? "",
                leagueName: league.name
            )
        }
}
