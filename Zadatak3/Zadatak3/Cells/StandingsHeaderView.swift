//
//  StandingsHeaderView.swift
//  Zadatak3
//

import UIKit
import SnapKit

class StandingsHeaderView: UITableViewHeaderFooterView {

    static let reuseIdentifier = "StandingsHeader"

    private let positionLabel = UILabel()
    private let teamLabel = UILabel()
    private let statsStack = UIStackView()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        let background = UIView()
        background.backgroundColor = .white
        backgroundView = background

        styleViews()
        layoutViews()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func styleViews() {
        positionLabel.text = "#"
        teamLabel.text = "Team"

        [positionLabel, teamLabel].forEach {
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .sofaGray
        }
        positionLabel.textAlignment = .center

        statsStack.axis = .horizontal
        statsStack.distribution = .fill
        statsStack.alignment = .center
    }

    private func layoutViews() {
        contentView.addSubview(positionLabel)
        contentView.addSubview(teamLabel)
        contentView.addSubview(statsStack)

        positionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(8)
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(16)
        }

        teamLabel.snp.makeConstraints {
            $0.leading.equalTo(positionLabel.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(16)
        }

        statsStack.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(16)
        }
    }

    func configure(columns: [StandingsColumn]) {
        statsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for column in columns {
            let label = UILabel()
            label.text = column.title
            label.font = .systemFont(ofSize: 14)
            label.textColor = .sofaGray
            label.textAlignment = .center
            label.snp.makeConstraints { $0.width.equalTo(column.width) }
            statsStack.addArrangedSubview(label)
        }
    }
}
