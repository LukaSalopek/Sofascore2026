//
//  LeagueHeaderView.swift
//  Zadatak3
//

import UIKit
import SnapKit

class LeagueHeaderView: UITableViewHeaderFooterView {

    private let leagueView = LeagueView()

    static let reuseIdentifier = "LeagueHeader"

    var onTap: (() -> Void)?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        contentView.addSubview(leagueView)

        leagueView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        contentView.addGestureRecognizer(tap)
        contentView.isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        onTap = nil
    }

    @objc private func handleTap() {
        onTap?()
    }

    func configure(with league: League, logo: UIImage) {
        leagueView.configure(
            countryName: league.country?.name ?? "",
            leagueName: league.name,
            leagueLogo: logo
        )
    }
}
