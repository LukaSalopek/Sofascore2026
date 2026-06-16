//
//  IncidentMapper.swift
//  Zadatak3
//

import UIKit

enum IncidentRow {
    case goal(GoalIncidentViewModel)
    case foul(FoulIncidentViewModel)
    case period(String)
}

enum GoalIcon {
    case image(UIImage)
    case points(String)
}

struct GoalIncidentViewModel {
    let isHome: Bool
    let icon: GoalIcon
    let player: String
    let score: String
    let minute: String
}

struct FoulIncidentViewModel {
    let isHome: Bool
    let icon: UIImage
    let player: String
    let type: String
    let minute: String
}

enum IncidentMapper {

    static func makeRows(from incidents: [Incident], sport: String) -> [IncidentRow] {
        var homeScore = 0
        var awayScore = 0
        var rows: [IncidentRow] = []

        for incident in incidents {
            switch incident.type {
            case "GOAL":
                let isHome = incident.isHomeTeam ?? true
                let points = incident.scoreDiff ?? 0

                if isHome {
                    homeScore += points
                } else {
                    awayScore += points
                }

                rows.append(.goal(GoalIncidentViewModel(
                    isHome: isHome,
                    icon: goalIcon(sport: sport, points: points),
                    player: incident.player ?? "",
                    score: normalizedScore(incident.score) ?? "\(homeScore) - \(awayScore)",
                    minute: minuteText(incident)
                )))

            case "FOUL", "YELLOW_CARD", "RED_CARD":
                rows.append(.foul(FoulIncidentViewModel(
                    isHome: incident.isHomeTeam ?? true,
                    icon: icon(for: incident.type),
                    player: incident.player ?? "",
                    type: typeLabel(for: incident.type),
                    minute: minuteText(incident)
                )))

            case "PERIOD_END":
                rows.append(.period(periodTitle(incident)))

            default:
                break
            }
        }

        return rows.reversed()
    }

    private static func minuteText(_ incident: Incident) -> String {
        (incident.extraMinute ?? 0) > 0
            ? "\(incident.minute)+\(incident.extraMinute ?? 0)'"
            : "\(incident.minute)'"
    }

    private static func periodTitle(_ incident: Incident) -> String {
        let description = incident.description ?? ""

        if description.contains("(") {
            return description
        }

        if let score = normalizedScore(incident.score) {
            return "\(description) (\(score))"
        }

        return description
    }

    private static func normalizedScore(_ score: String?) -> String? {
        guard let score, !score.isEmpty else { return nil }

        let parts = score
            .split(separator: "-")
            .map { $0.trimmingCharacters(in: .whitespaces) }

        guard parts.count == 2 else { return score }

        return "\(parts[0]) - \(parts[1])"
    }

    private static func normalizedSport(_ sport: String) -> String {
        let value = sport.lowercased()

        if value.contains("basket") {
            return "basketball"
        }
        if value.contains("am") || value.contains("american") {
            return "am-football"
        }
        return "football"
    }

    private static func goalIcon(sport: String, points: Int) -> GoalIcon {
        switch normalizedSport(sport) {
        case "basketball":
            return .points("\(points)")
        case "am-football":
            return .image(amFootballIcon(points: points))
        default:
            return .image(UIImage(named: "ic_goal_football") ?? UIImage())
        }
    }

    private static func amFootballIcon(points: Int) -> UIImage {
        let name: String
        switch points {
        case 6:
            name = "ic_goal_am_football"
        case 3, 1:
            name = "ic_field_goal_am_football"
        case 2:
            name = "ic_two_point_am_football"
        default:
            name = "ic_goal_am_football"
        }
        return UIImage(named: name) ?? UIImage()
    }

    private static func icon(for type: String) -> UIImage {
        switch type {
        case "YELLOW_CARD":
            return UIImage(named: "ic_yellow_card") ?? UIImage()
        case "RED_CARD":
            return UIImage(named: "ic_yellow_card")?
                .withTintColor(.sofaRedCard, renderingMode: .alwaysOriginal) ?? UIImage()
        default:
            return UIImage(named: "ic_yellow_card")?
                .withTintColor(.sofaGray, renderingMode: .alwaysOriginal) ?? UIImage()
        }
    }

    private static func typeLabel(for type: String) -> String {
        switch type {
        case "YELLOW_CARD": return "Yellow card"
        case "RED_CARD":    return "Red card"
        case "FOUL":        return "Foul"
        default:            return ""
        }
    }
}
