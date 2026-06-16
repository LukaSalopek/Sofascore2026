//
//  StandingsHeaderView.swift
//  Zadatak3
//

import UIKit
import SnapKit

class StandingsHeaderView: UITableViewHeaderFooterView {

    static let reuseIdentifier = "StandingsHeader"

    private let rowView = StandingsHeaderRowView()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        let background = UIView()
        background.backgroundColor = .white
        backgroundView = background

        contentView.addSubview(rowView)
        rowView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(columns: [StandingsColumn]) {
        rowView.configure(columns: columns)
    }
}
