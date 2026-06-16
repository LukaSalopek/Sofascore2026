//
//  IncidentsEmptyView.swift
//  Zadatak3
//

import UIKit
import SnapKit
import SofaAcademic

class IncidentsEmptyView: BaseView {

    private let background = UIView()
    private let card = UIView()
    private let messageLabel = UILabel()
    private let tournamentButton = UIButton(type: .system)

    var onTournamentTap: (() -> Void)?

    override func addViews() {
        addSubview(background)
        background.addSubview(card)
        card.addSubview(messageLabel)
        background.addSubview(tournamentButton)
    }

    override func styleViews() {
        background.backgroundColor = .white

        card.backgroundColor = .sofaEventDetailsBackground
        card.layer.cornerRadius = 8
        card.clipsToBounds = true

        messageLabel.text = "No results yet."
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.textColor = .sofaGray
        messageLabel.textAlignment = .center

        tournamentButton.setTitle("View Tournament Details", for: .normal)
        tournamentButton.setTitleColor(.sofaBlue, for: .normal)
        tournamentButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        tournamentButton.backgroundColor = .white
        tournamentButton.layer.cornerRadius = 8
        tournamentButton.layer.borderWidth = 1
        tournamentButton.layer.borderColor = UIColor.sofaBlue.cgColor
        tournamentButton.addTarget(self, action: #selector(tournamentTapped), for: .touchUpInside)
    }

    override func setupConstraints() {
        background.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(148)
        }

        card.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(52)
        }

        messageLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        tournamentButton.snp.makeConstraints {
            $0.top.equalTo(card.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(74)
            $0.height.equalTo(40)
        }
    }

    @objc private func tournamentTapped() {
        onTournamentTap?()
    }

    func setShowsTournamentButton(_ shows: Bool) {
        tournamentButton.isHidden = !shows
    }
}
