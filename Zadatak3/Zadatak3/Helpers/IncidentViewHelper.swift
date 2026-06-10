//
//  IncidentViewHelper.swift
//  Zadatak3
//
//  Created by akademija on 08.06.2026..
//

import UIKit

enum IncidentViewHelper {

    static func makeViews(from incidents: [Incident], sport: String) -> [UIView] {
        let maxPeriodMinute = incidents
            .filter { $0.type == "PERIOD_END" }
            .map { $0.minute }
            .max()

        return incidents.reversed().map { incident in
            make(incident, sport: sport, maxPeriodMinute: maxPeriodMinute)
        }
    }

    private static func make(_ incident: Incident, sport: String, maxPeriodMinute: Int?) -> UIView {
        switch incident.type {
        case "GOAL":
            let view = GoalIncidentView()
            view.setSide(incident.isHomeTeam ?? true ? .home : .away)
            view.setImage(image: goalIcon(sport: sport))
            view.setPlayerName(playerName: incident.player ?? "")
            view.setScore(score: incident.score ?? "")
            view.setIncidentMinute(minute: minuteText(incident))
            return view

        case "FOUL", "YELLOW_CARD", "RED_CARD":
            let view = FoulIncidentView()
            view.setSide(incident.isHomeTeam ?? true ? .home : .away)
            view.setImage(image: icon(for: incident.type))
            view.setPlayerName(playerName: incident.player ?? "")
            view.setIncidentType(incidentType: typeLabel(for: incident.type))
            view.setIncidentMinute(minute: minuteText(incident))
            return view

        case "PERIOD_END":
            let view = PeriodIncidentView()
            let isFT = incident.minute == maxPeriodMinute
            view.setTitle("\(isFT ? "FT" : "HT") (\(incident.score ?? ""))")
            return view

        default:
            return UIView()
        }
    }


    private static func minuteText(_ incident: Incident) -> String {
        (incident.extraMinute ?? 0) > 0
            ? "\(incident.minute)+\(incident.extraMinute ?? 0)'"
            : "\(incident.minute)'"
    }

    private static func goalIcon(sport: String) -> UIImage {
        UIImage(named: "icon-goal") ?? UIImage()
    }

    private static func icon(for type: String) -> UIImage {
        switch type {
        case "YELLOW_CARD": return UIImage(named: "icon-yellow-card") ?? UIImage()
        case "RED_CARD":    return UIImage(named: "icon-red-card") ?? UIImage()
        default:            return UIImage(named: "icon-foul") ?? UIImage()
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
