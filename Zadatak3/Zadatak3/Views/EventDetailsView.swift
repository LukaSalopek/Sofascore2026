//
//  EventDetailsView.swift
//  Zadatak3
//
//  Created by akademija on 29.03.2026..
//

import UIKit
import SnapKit
import SofaAcademic

class EventDetailsView : BaseView {
    
    private var homeTeamCard = TeamCard()
    private var awayTeamCard = TeamCard()
    
    private var matchDate = UILabel()
    private var matchTime = UILabel()
    
    private var homeScoreLabel = UILabel()
    private var scoreSeparatorLabel = UILabel()
    private var awayScoreLabel = UILabel()
    private var scoreStackView = UIStackView()
    
    private var spacer = UIView()
    private var matchMinute = UILabel()
    
    private var infoStack = UIStackView()
    private var mainStack = UIStackView()
    
    override func addViews(){
        addSubview(mainStack)

        mainStack.addArrangedSubview(homeTeamCard)
        mainStack.addArrangedSubview(infoStack)
        mainStack.addArrangedSubview(awayTeamCard)
        
        infoStack.addArrangedSubview(spacer)
        infoStack.addArrangedSubview(matchDate)
        infoStack.addArrangedSubview(matchTime)
        
        infoStack.addArrangedSubview(scoreStackView)
        scoreStackView.addArrangedSubview(homeScoreLabel)
        scoreStackView.addArrangedSubview(scoreSeparatorLabel)
        scoreStackView.addArrangedSubview(awayScoreLabel)
        
        infoStack.addArrangedSubview(matchMinute)
    }
    
    override func styleViews(){
        mainStack.axis = .horizontal
        mainStack.distribution = .fill
        mainStack.alignment = .top
        
        infoStack.axis = .vertical
        infoStack.alignment = .center
        infoStack.setCustomSpacing(4, after: matchDate)
        
        scoreStackView.axis = .horizontal
        scoreStackView.spacing = 4
        scoreStackView.alignment = .center
        
        [homeScoreLabel, scoreSeparatorLabel, awayScoreLabel].forEach {
            $0.font = .systemFont(ofSize: 32, weight: .bold)
            $0.textAlignment = .center
        }
        
        matchDate.font = .systemFont(ofSize: 12)
        matchTime.font = .systemFont(ofSize: 12)
        matchMinute.font = .systemFont(ofSize: 12)
        matchMinute.textAlignment = .center
        
        scoreSeparatorLabel.text = "-"
    }
    
    override func setupConstraints(){
        mainStack.snp.makeConstraints{
            $0.leading.trailing.top.bottom.equalToSuperview().inset(16)
        }
        
        spacer.snp.makeConstraints{
            $0.height.equalTo(8)
        }
        homeScoreLabel.snp.makeConstraints{
            $0.height.equalTo(40)
        }
        scoreSeparatorLabel.snp.makeConstraints{
            $0.height.equalTo(40)
        }
        awayScoreLabel.snp.makeConstraints{
            $0.height.equalTo(40)
        }
        matchMinute.snp.makeConstraints{
            $0.height.equalTo(16)
        }
    }
    
    func configure(with match: Event) {
        homeTeamCard.configure(teamName: match.homeTeam.name, image: match.homeTeamLogo )
        awayTeamCard.configure(teamName: match.awayTeam.name, image: match.awayTeamLogo)
        
        homeTeamCard.updateNameColor(color: .sofaTextBlack)
        awayTeamCard.updateNameColor(color: .sofaTextBlack)
        
        switch match.status {
        case .inProgress:
            showLiveUI(match: match)
        case .notStarted:
            showUpcomingUI(timestamp: match.startTimestamp)
        case .finished:
            showFinishedUI(match: match)
        case .halftime:
            showHalftimeUI(match: match)
        }
    }
    
    private func showLiveUI(match: Event) {
        toggleScoreUI(showScore: true)
        homeScoreLabel.text = "\(match.homeTeamScore)"
        awayScoreLabel.text = "\(match.awayTeamScore)"
        
        [homeScoreLabel, scoreSeparatorLabel, awayScoreLabel].forEach { $0.textColor = .sofaLiveRed }
        
        matchMinute.text = "\(match.timeDifference)'"
        matchMinute.textColor = .sofaLiveRed
    }
    
    private func showUpcomingUI(timestamp: Int) {
        toggleScoreUI(showScore: false)
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy."
        matchDate.text = formatter.string(from: date)
        formatter.dateFormat = "HH:mm"
        matchTime.text = formatter.string(from: date)
    }
    
    private func showFinishedUI(match: Event) {
        toggleScoreUI(showScore: true)
        homeScoreLabel.text = "\(match.homeTeamScore)"
        awayScoreLabel.text = "\(match.awayTeamScore)"
        
        let colors = ViewControllerHelper.getTeamColors(homeScore: match.homeTeamScore, awayScore: match.awayTeamScore)
        homeScoreLabel.textColor = colors.home
        awayScoreLabel.textColor = colors.away
        scoreSeparatorLabel.textColor = .sofaGray
        
        matchMinute.text = "Full Time"
        matchMinute.textColor = .sofaGray
    }

    private func showHalftimeUI(match: Event) {
        toggleScoreUI(showScore: true)
        homeScoreLabel.text = "\(match.homeTeamScore)"
        awayScoreLabel.text = "\(match.awayTeamScore)"
        
        [homeScoreLabel, scoreSeparatorLabel, awayScoreLabel].forEach { $0.textColor = .sofaLiveRed }
        matchMinute.text = AppStrings.halftime
        matchMinute.textColor = .sofaLiveRed
    }
    
    private func toggleScoreUI(showScore: Bool) {
        scoreStackView.isHidden = !showScore
        matchMinute.isHidden = !showScore
        spacer.isHidden = showScore
        matchDate.isHidden = showScore
        matchTime.isHidden = showScore
    }
}

class TeamCard : UIView {
    
    private var teamName = UILabel()
    private var teamIcon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupStyles()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func addViews() {
        addSubview(teamIcon)
        addSubview(teamName)
    }
    
    func setupStyles(){
        teamName.font = .systemFont(ofSize: 12, weight: .bold)
        teamName.textColor = .sofaTextBlack
        teamName.numberOfLines = 2
        teamName.lineBreakMode = .byTruncatingTail
        teamName.textAlignment = .center
        teamIcon.contentMode = .scaleAspectFit
    }
    
    func setupConstraints(){
        teamIcon.snp.makeConstraints{
            $0.size.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(40)
        }
        
        teamName.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(teamIcon.snp.bottom).offset(8)
            $0.centerX.equalTo(teamIcon)
        }
    }
    
    func configure(teamName : String, image : UIImage){
        self.teamName.text = teamName
        self.teamIcon.image = image
    }

    func updateNameColor(color: UIColor) {
        self.teamName.textColor = color
    }
}
