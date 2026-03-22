//
//  MatchTableViewCell.swift
//  Zadatak3
//
//  Created by akademija on 22.03.2026..
//

import UIKit
import SnapKit
import SofaAcademic

class MatchTableViewCell: UITableViewCell {
    private let matchView = MatchView()
    private var helper = ViewControllerHelper()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(matchView)
        matchView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    override func prepareForReuse() {
            super.prepareForReuse()
            matchView.updateScore(homeScore: "", awayScore: "")
            resetMatchViewStyles()
        }

    private func resetMatchViewStyles() {
        matchView.setTeamColors(homeTeamColor: .black, awayTeamColor: .black)
        matchView.updateTime(time: "")
    }

    func configure(with match: Event) {
        resetMatchViewStyles()
        
        matchView.updateHomeLogo(homeTeam: match.homeTeamLogo)
        matchView.updateAwayLogo(awayTeam: match.awayTeamLogo)
        matchView.setMatch(homeTeamName: match.homeTeam.name,
                           awayTeamName: match.awayTeam.name,
                           matchTime: match.dataFormat)
        
        configureMatchStatus(match)
    }

    private func configureMatchStatus(_ match: Event) {
        switch match.status {
        case .notStarted:
            matchNotStarted(match)
        case .inProgress:
            matchInProgress(match)
        case .halftime:
            matchHalfTime(match)
        case .finished:
            matchFinished(match)
        }
    }


    private func matchNotStarted(_ match: Event) {
        matchView.updateTime(time: AppStrings.notStarted)
        matchView.updateScore(homeScore: "", awayScore: "")
    }

    private func matchInProgress(_ match: Event) {
        updateLiveStatus(match: match)
        matchView.updateTime(time: "\(match.timeDifference)'")
    }

    private func matchHalfTime(_ match: Event) {
        updateLiveStatus(match: match)
        matchView.updateTime(time: AppStrings.halftime)
    }

    private func matchFinished(_ match: Event) {
        matchView.updateScore(homeScore: String(match.getHomeTeamScore),
                              awayScore: String(match.getAwayTeamScore))
        matchView.updateTime(time: AppStrings.finished)
        
        let colors = helper.setTeamColors(homeTeamScore: match.getHomeTeamScore,
                                          awayTeamScore: match.getAwayTeamScore)
        matchView.setTeamColors(homeTeamColor: colors[0], awayTeamColor: colors[1])
    }

    private func updateLiveStatus(match: Event) {
        matchView.updateScore(homeScore: String(match.getHomeTeamScore),
                              awayScore: String(match.getAwayTeamScore))
        matchView.isLive()
    }
    

}
