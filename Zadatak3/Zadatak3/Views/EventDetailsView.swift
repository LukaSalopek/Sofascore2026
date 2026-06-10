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
    private var mainStack = UIStackView()
    private var infoStack = UIStackView()

    private var spacer = UIView()
    private var matchDate = UILabel()
    private var matchTime = UILabel()

    private var scoreStackView = UIStackView()
    private var homeScoreLabel = UILabel()
    private var scoreSeparatorLabel = UILabel()
    private var awayScoreLabel = UILabel()

    private var matchMinute = UILabel()
    private var awayTeamCard = TeamCard()

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

        matchDate.font = .systemFont(ofSize: 12)
        matchTime.font = .systemFont(ofSize: 12)

        scoreStackView.axis = .horizontal
        scoreStackView.spacing = 4
        scoreStackView.alignment = .center
        scoreStackView.distribution = .fill

        homeScoreLabel.font = .systemFont(ofSize: 32, weight: .bold)
        homeScoreLabel.textAlignment = .right

        scoreSeparatorLabel.font = .systemFont(ofSize: 32, weight: .bold)
        scoreSeparatorLabel.textAlignment = .center
        scoreSeparatorLabel.text = "-"

        awayScoreLabel.font = .systemFont(ofSize: 32, weight: .bold)
        awayScoreLabel.textAlignment = .left

        matchMinute.font = .systemFont(ofSize: 12)
        matchMinute.textAlignment = .center
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
            $0.leading.equalToSuperview()
        }

        scoreSeparatorLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }

        awayScoreLabel.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.trailing.equalToSuperview()
        }

        matchMinute.snp.makeConstraints{
            $0.height.equalTo(16)
        }
    }

    func configure(with model: EventDetailsDisplayModel) {
            homeTeamCard.configure(teamName: model.homeTeamName, image: UIImage())
            awayTeamCard.configure(teamName: model.awayTeamName, image: UIImage())

        loadImage(from: model.homeTeamLogoURL ?? "") { [weak self] image in
                self?.homeTeamCard.updateImage(image: image ?? UIImage())
            }

        loadImage(from: model.awayTeamLogoURL ?? "") { [weak self] image in
                self?.awayTeamCard.updateImage(image: image ?? UIImage())
            }

            homeTeamCard.updateNameColor(color: .sofaTextBlack)
            awayTeamCard.updateNameColor(color: .sofaTextBlack)

            switch model.state {
            case .upcoming(let date, let time):
                setupUpcomingUI(date: date, time: time)

            case .live(let homeTeamScore, let awayTeamScore, let minute):
                setupLiveUI(homeScore: homeTeamScore, awayScore: awayTeamScore, minute: minute)

            case .halftime(let homeTeamScore, let awayTeamScore):
                setupHalftimeUI(homeScore: homeTeamScore, awayScore: awayTeamScore)

            case .finished(let homeTeamScore, let awayTeamScore, let homeTeamColor, let awayTeamColor):
                setupFinishedUI(homeScore: homeTeamScore, awayScore: awayTeamScore, homeColor: homeTeamColor, awayColor: awayTeamColor)
            }
        }

        private func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }

            URLSession.shared.dataTask(with: url) { data, _, error in
                guard error == nil,
                      let data = data,
                      let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }

                DispatchQueue.main.async {
                    completion(image)
                }
            }.resume()
        }



    private func setupLiveUI(homeScore: String, awayScore: String, minute: String) {
        toggleScoreUI(showScore: true)
        homeScoreLabel.text = homeScore
        awayScoreLabel.text = awayScore

        [homeScoreLabel, scoreSeparatorLabel, awayScoreLabel].forEach { $0.textColor = .sofaLiveRed }

        matchMinute.text = minute
        matchMinute.textColor = .sofaLiveRed
    }

    private func setupUpcomingUI(date: String, time: String) {
        toggleScoreUI(showScore: false)
        matchDate.text = date
        matchTime.text = time
    }

    private func setupFinishedUI(homeScore: String, awayScore: String, homeColor: UIColor, awayColor: UIColor) {
        toggleScoreUI(showScore: true)
        homeScoreLabel.text = homeScore
        awayScoreLabel.text = awayScore

        homeScoreLabel.textColor = homeColor
        awayScoreLabel.textColor = awayColor
        scoreSeparatorLabel.textColor = .sofaGray

        matchMinute.text = "Full Time"
        matchMinute.textColor = .sofaGray
    }

    private func setupHalftimeUI(homeScore: String, awayScore: String) {
        toggleScoreUI(showScore: true)
        homeScoreLabel.text = homeScore
        awayScoreLabel.text = awayScore

        [homeScoreLabel, scoreSeparatorLabel, awayScoreLabel].forEach { $0.textColor = .sofaLiveRed }

        matchMinute.text = "Half Time"
        matchMinute.textColor = .sofaLiveRed
    }

    private func toggleScoreUI(showScore: Bool) {
        scoreStackView.isHidden = !showScore
        matchMinute.isHidden = !showScore
        spacer.isHidden = showScore
        matchDate.isHidden = showScore
        matchTime.isHidden = showScore
    }

    func updateLogos(
        homeLogo: UIImage,
        awayLogo: UIImage
    ) {
        homeTeamCard.updateImage(image: homeLogo)
        awayTeamCard.updateImage(image: awayLogo)
    }
}
