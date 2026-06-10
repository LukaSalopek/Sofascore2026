//
//  FoulIncidentCell.swift
//  Zadatak3
//

import UIKit
import SnapKit

final class FoulIncidentCell: UITableViewCell {

    static let reuseIdentifier = "FoulIncidentCell"

    private let incidentView = FoulIncidentView()

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

    func configure(with model: FoulIncidentViewModel) {
        incidentView.setSide(model.isHome ? .home : .away)
        incidentView.setImage(image: model.icon)
        incidentView.setPlayerName(playerName: model.player)
        incidentView.setIncidentType(incidentType: model.type)
        incidentView.setIncidentMinute(minute: model.minute)
    }
}
