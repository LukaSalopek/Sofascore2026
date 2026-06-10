//
//  IncidentsEmptyView.swift
//  Zadatak3
//

import UIKit
import SnapKit
import SofaAcademic

class IncidentsEmptyView: BaseView {

    private let card = UIView()
    private let messageLabel = UILabel()
    private let tournamentButton = UIButton(type: .system)

    override func addViews() {
        addSubview(card)
        card.addSubview(messageLabel)
        addSubview(tournamentButton)
    }

    override func styleViews() {
        card.backgroundColor = .white
        card.layer.cornerRadius = 8
        card.clipsToBounds = true

        messageLabel.text = "No results yet."
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.textColor = .sofaGray
        messageLabel.textAlignment = .center

        tournamentButton.setTitle("View Tournament Details", for: .normal)
        tournamentButton.setTitleColor(.sofaBlue, for: .normal)
        tournamentButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        tournamentButton.backgroundColor = .white
        tournamentButton.layer.cornerRadius = 8
        tournamentButton.layer.borderWidth = 1
        tournamentButton.layer.borderColor = UIColor.sofaBlue.cgColor
    }

    override func setupConstraints() {
        card.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        messageLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(14)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        tournamentButton.snp.makeConstraints {
            $0.top.equalTo(card.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
    }

    func setShowsTournamentButton(_ shows: Bool) {
        tournamentButton.isHidden = !shows
    }
}
