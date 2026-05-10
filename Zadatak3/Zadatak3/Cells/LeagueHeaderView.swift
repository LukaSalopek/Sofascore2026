//
//  LeagueHeaderView.swift
//  Zadatak3
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
        
        leagueView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with league: League) {
        leagueView.configure(
            countryName: league.country?.name ?? "",
            leagueName: league.name,
            leagueLogo: UIImage()
        )
        
        Task {
            let image = await APIClient.shared.fetchImage(from: league.logoUrl)
            
            DispatchQueue.main.async { [weak self] in
                self?.leagueView.configure(
                    countryName: league.country?.name ?? "",
                    leagueName: league.name,
                    leagueLogo: image ?? UIImage()
                )
            }
        }
    }
}
