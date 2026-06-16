//
//  StandingsCell.swift
//  Zadatak3
//

import UIKit
import SnapKit

class StandingsCell: UITableViewCell {

    static let reuseIdentifier = "StandingsCell"

    private let rowView = StandingsRowView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .white
        contentView.backgroundColor = .white

        contentView.addSubview(rowView)
        rowView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(with standings: Standings, columns: [StandingsColumn]) {
        rowView.configure(with: standings, columns: columns)
    }
}
