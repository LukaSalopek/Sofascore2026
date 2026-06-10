//
//  GoalIncidentView.swift
//  Zadatak3
//
//  Created by akademija on 08.06.2026..
//

import SnapKit
import SofaAcademic
import UIKit

class GoalIncidentView: BaseView {

    enum Side { case home, away }

    private let incidentImage = UIImageView()
    private let incidentMinute = UILabel()
    private let separatarLine = UIView()
    private let scoreLabel = UILabel()
    private let playerName = UILabel()
    private let scoreGuide = UILayoutGuide()

    override func addViews() {
        addSubview(incidentImage)
        addSubview(incidentMinute)
        addSubview(separatarLine)
        addSubview(scoreLabel)
        addSubview(playerName)
        addLayoutGuide(scoreGuide)
    }

    override func styleViews() {
        incidentMinute.textColor = .sofaGray
        incidentMinute.textAlignment = .center
        incidentMinute.font = .systemFont(ofSize: 12)

        separatarLine.backgroundColor = .sofaSeparator

        scoreLabel.font = .systemFont(ofSize: 20, weight: .bold)
        scoreLabel.textColor = .sofaTextBlack
        scoreLabel.textAlignment = .center
        scoreLabel.setContentHuggingPriority(.required, for: .horizontal)
        scoreLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        playerName.font = .sofaTeamName
        playerName.numberOfLines = 1
        playerName.lineBreakMode = .byTruncatingTail
        playerName.textColor = .sofaTextBlack
    }

    override func setupConstraints() {
        incidentImage.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
        }

        incidentMinute.snp.makeConstraints {
            $0.top.equalTo(incidentImage.snp.bottom).offset(2)
            $0.centerX.equalTo(incidentImage)
            $0.width.equalTo(40)
            $0.height.equalTo(16)
            $0.bottom.equalToSuperview().inset(8)
        }

        separatarLine.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(40)
            $0.leading.equalTo(incidentMinute.snp.trailing).offset(7)
            $0.centerY.equalToSuperview()
        }

        playerName.snp.makeConstraints {
            $0.leading.equalTo(separatarLine.snp.trailing).offset(100)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }


        scoreGuide.snp.makeConstraints {
            $0.leading.equalTo(separatarLine.snp.trailing)
            $0.trailing.equalTo(playerName.snp.leading)
            $0.centerY.equalToSuperview()
        }


        scoreLabel.snp.makeConstraints {
            $0.centerX.equalTo(scoreGuide.snp.centerX)
            $0.centerY.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(separatarLine.snp.trailing).offset(8)
            $0.trailing.lessThanOrEqualTo(playerName.snp.leading).offset(-8)
        }
    }


    func setSide(_ side: Side) {
        semanticContentAttribute = (side == .home) ? .forceLeftToRight : .forceRightToLeft
        playerName.textAlignment = .natural
    }


    func setImage(image: UIImage) {
        incidentImage.image = image
    }
    func setPlayerName(playerName name: String) {
        playerName.text = name
    }
    func setScore(score: String) {
        scoreLabel.text = score
    }
    func setIncidentMinute(minute incidentMinute: String) {
        self.incidentMinute.text = incidentMinute
    }
}
