//
//  StandingsCell.swift
//  Zadatak3
//

import UIKit
import SnapKit

enum StandingsColumn {
    case played
    case wins
    case draws
    case losses
    case goals
    case diff
    case points
    case percentage

    static let positionWidth: CGFloat = 28

    static func columns(for sport: String) -> [StandingsColumn] {
        let value = sport.lowercased()

        if value.contains("basket") {
            return [.played, .wins, .losses, .diff, .percentage]
        }
        if value.contains("am") || value.contains("american") {
            return [.played, .wins, .draws, .losses, .percentage]
        }
        return [.played, .wins, .draws, .losses, .goals, .points]
    }

    var title: String {
        switch self {
        case .played: return "P"
        case .wins: return "W"
        case .draws: return "D"
        case .losses: return "L"
        case .goals: return "Goals"
        case .diff: return "DIFF"
        case .points: return "PTS"
        case .percentage: return "PCT"
        }
    }

    var width: CGFloat {
        switch self {
        case .goals: return 48
        case .diff: return 44
        case .percentage: return 48
        case .points: return 36
        default: return 28
        }
    }

    func value(for standings: Standings) -> String {
        switch self {
        case .played: return "\(standings.matches ?? 0)"
        case .wins: return "\(standings.wins ?? 0)"
        case .draws: return "\(standings.draws ?? 0)"
        case .losses: return "\(standings.losses ?? 0)"
        case .goals:
            if let scoreFor = standings.scoreFor, let scoreAgainst = standings.scoreAgainst {
                return "\(scoreFor):\(scoreAgainst)"
            }
            return standings.scoreFormatted ?? "-"
        case .diff:
            if let scoreFor = standings.scoreFor, let scoreAgainst = standings.scoreAgainst {
                return "\(scoreFor - scoreAgainst)"
            }
            return "-"
        case .points: return "\(standings.points ?? 0)"
        case .percentage:
            guard let percentage = standings.percentage else { return "-" }
            return StandingsColumn.percentageFormatter.string(from: NSNumber(value: percentage)) ?? "-"
        }
    }

    private static let percentageFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        formatter.decimalSeparator = "."
        return formatter
    }()
}

class StandingsCell: UITableViewCell {

    static let reuseIdentifier = "StandingsCell"

    private let positionBadge = UIView()
    private let positionLabel = UILabel()
    private let teamName = UILabel()
    private let statsStack = UIStackView()

    private static let badgeSize: CGFloat = 28

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .white
        contentView.backgroundColor = .white

        styleViews()
        layoutViews()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func styleViews() {
        positionBadge.backgroundColor = .sofaIncidentBackgrund
        positionBadge.layer.cornerRadius = StandingsCell.badgeSize / 2
        positionBadge.clipsToBounds = true

        positionLabel.font = .systemFont(ofSize: 13)
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

    private func layoutViews() {
        contentView.addSubview(positionBadge)
        positionBadge.addSubview(positionLabel)
        contentView.addSubview(teamName)
        contentView.addSubview(statsStack)

        positionBadge.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(StandingsCell.badgeSize)
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(8)
        }

        positionLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        teamName.snp.makeConstraints {
            $0.leading.equalTo(positionBadge.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualTo(statsStack.snp.leading).offset(-8)
        }

        statsStack.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }

    func configure(with standings: Standings, columns: [StandingsColumn]) {
        positionLabel.text = "\(standings.position)"
        teamName.text = standings.team.name

        statsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

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
