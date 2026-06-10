//
//  GoalIncidentCell.swift
//  Zadatak3
//

import UIKit
import SnapKit

final class GoalIncidentCell: UITableViewCell {

    static let reuseIdentifier = "GoalIncidentCell"

    private let incidentView = GoalIncidentView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .white
        contentView.backgroundColor = .white

        contentView.addSubview(incidentView)
        incidentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: GoalIncidentViewModel) {
        incidentView.setSide(model.isHome ? .home : .away)
        incidentView.setIcon(model.icon)
        incidentView.setPlayerName(playerName: model.player)
        incidentView.setScore(score: model.score)
        incidentView.setIncidentMinute(minute: model.minute)
    }
}
