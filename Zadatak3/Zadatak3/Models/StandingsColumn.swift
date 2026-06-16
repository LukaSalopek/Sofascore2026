//
//  StandingsColumn.swift
//  Zadatak3
//

import UIKit

enum StandingsColumn {
    case played
    case wins
    case draws
    case losses
    case goals
    case diff
    case points
    case percentage

    static let positionWidth: CGFloat = 24

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
        case .goals: return 40
        case .diff: return 44
        case .percentage: return 48
        case .points: return 32
        default: return 24
        }
    }

    static func stackWidth(for columns: [StandingsColumn]) -> CGFloat {
        if columns.contains(.goals) { return 200 }
        if columns.contains(.diff) { return 224 }
        return 168
    }

    static func spacing(for columns: [StandingsColumn]) -> CGFloat {
        guard columns.count > 1 else { return 0 }
        let used = columns.reduce(0) { $0 + $1.width }
        return max(0, (stackWidth(for: columns) - used) / CGFloat(columns.count - 1))
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
