//
//  MatchTableViewCell.swift
//  Zadatak3
//

import UIKit
import SnapKit

class MatchTableViewCell: UITableViewCell {
    
    private let matchView = MatchView()
    
    static let reuseIdentifier = "MatchCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(matchView)
        
        matchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        matchView.updateScore(homeScore: "", awayScore: "")
        matchView.updateHomeLogo(homeTeam: UIImage())
        matchView.updateAwayLogo(awayTeam: UIImage())
        
        resetMatchViewStyles()
    }

    private func resetMatchViewStyles() {
        matchView.setTeamColors(
            homeTeamColor: .sofaTextBlack,
            awayTeamColor: .sofaTextBlack
        )
        
        matchView.updateTime(time: "")
        matchView.updateTimeColor(color: .sofaGray)
    }

    func configure(with match: Event, homeLogo: UIImage, awayLogo: UIImage) {
        resetMatchViewStyles()
        
        matchView.setMatch(
            homeTeamName: match.homeTeam.name,
            awayTeamName: match.awayTeam.name,
            matchTime: match.formattedStartTime
        )
        
        matchView.updateHomeLogo(homeTeam: homeLogo)
        matchView.updateAwayLogo(awayTeam: awayLogo)
        
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
        matchView.updateScore(
            homeScore: String(match.homeTeamScore),
            awayScore: String(match.awayTeamScore)
        )
        
        matchView.updateTime(time: AppStrings.finished)
        
        let colors = ViewControllerHelper.getTeamColors(
            homeScore: match.homeTeamScore,
            awayScore: match.awayTeamScore
        )
        
        matchView.setTeamColors(
            homeTeamColor: colors.home,
            awayTeamColor: colors.away
        )
    }

    private func updateLiveStatus(match: Event) {
        matchView.updateScore(
            homeScore: String(match.homeTeamScore),
            awayScore: String(match.awayTeamScore)
        )
        
        matchView.isLive()
    }
}
