//
//  PeriodIncidentCell.swift
//  Zadatak3
//

import UIKit
import SnapKit

final class PeriodIncidentCell: UITableViewCell {

    static let reuseIdentifier = "PeriodIncidentCell"

    private let incidentView = PeriodIncidentView()

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

    func configure(title: String) {
        incidentView.setTitle(title)
    }
}
