//
//  StandingsRowView.swift
//  Zadatak3
//

import UIKit
import SnapKit
import SofaAcademic

class StandingsRowView: BaseView {

    private static let badgeSize: CGFloat = 24

    private let positionBadge = UIView()
    private let positionLabel = UILabel()
    private let teamName = UILabel()
    private let statsStack = UIStackView()

    override func addViews() {
        addSubview(positionBadge)
        positionBadge.addSubview(positionLabel)
        addSubview(teamName)
        addSubview(statsStack)
    }

    override func styleViews() {
        backgroundColor = .white

        positionBadge.backgroundColor = .sofaIncidentBackgrund
        positionBadge.layer.cornerRadius = StandingsRowView.badgeSize / 2
        positionBadge.clipsToBounds = true

        positionLabel.font = .systemFont(ofSize: 14)
        positionLabel.textColor = .sofaTextBlack
        positionLabel.textAlignment = .center

        teamName.font = .systemFont(ofSize: 14)
        teamName.textColor = .sofaTextBlack
        teamName.numberOfLines = 1
        teamName.lineBreakMode = .byTruncatingTail

        statsStack.axis = .horizontal
        statsStack.distribution = .fill
        statsStack.alignment = .center
    }

    override func setupConstraints() {
        positionBadge.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.size.equalTo(StandingsRowView.badgeSize)
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(12).priority(999)
        }

        positionLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        teamName.snp.makeConstraints {
            $0.leading.equalTo(positionBadge.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.width.lessThanOrEqualTo(104)
            $0.trailing.lessThanOrEqualTo(statsStack.snp.leading).offset(-8)
            $0.height.equalTo(16)
        }

        statsStack.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(16)
        }
    }

    func configure(with standings: Standings, columns: [StandingsColumn]) {
        positionLabel.text = "\(standings.position)"
        teamName.text = standings.team.name

        statsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        statsStack.spacing = StandingsColumn.spacing(for: columns)

        for column in columns {
            let label = UILabel()
            label.font = column == .points
                ? .systemFont(ofSize: 14, weight: .bold)
                : .systemFont(ofSize: 14)
            label.textColor = .sofaTextBlack
            label.textAlignment = .center
            label.text = column.value(for: standings)
            label.snp.makeConstraints { $0.width.equalTo(column.width) }
            statsStack.addArrangedSubview(label)
        }
    }
}
