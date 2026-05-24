//
//  LeagueHeaderView.swift
//  Zadatak3
//

import UIKit
import SnapKit

class LeagueHeaderView: UITableViewHeaderFooterView {
    
    private let leagueView = LeagueView()
    private var currentImageLoadTask: Task<Void, Never>?
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        currentImageLoadTask?.cancel()
    }
    
    func configure(with league: League) {
        currentImageLoadTask?.cancel()
        
        leagueView.configure(
            countryName: league.country?.name ?? "",
            leagueName: league.name,
            leagueLogo: UIImage()
        )
        
        currentImageLoadTask = Task { @MainActor in
            let image = await APIClient.shared.fetchImage(from: league.logoUrl)
            
            guard !Task.isCancelled else { return }
            
            self.leagueView.configure(
                countryName: league.country?.name ?? "",
                leagueName: league.name,
                leagueLogo: image ?? UIImage()
            )
        }
    }
}
