//
//  StandingsHeaderRowView.swift
//  Zadatak3
//

import UIKit
import SnapKit
import SofaAcademic

class StandingsHeaderRowView: BaseView {

    private let positionLabel = UILabel()
    private let teamLabel = UILabel()
    private let statsStack = UIStackView()

    override func addViews() {
        addSubview(positionLabel)
        addSubview(teamLabel)
        addSubview(statsStack)
    }

    override func styleViews() {
        backgroundColor = .white

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

    override func setupConstraints() {
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
        statsStack.spacing = StandingsColumn.spacing(for: columns)

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
