import UIKit
import SofaAcademic
import SnapKit

class ViewController: UIViewController {
    
    private var leagueView = LeagueView()
    private let data = Homework2DataSource()
    private lazy var matches = data.laLigaEvents()
    private lazy var league = data.laLigaLeague()
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        configureLeague()
        setupMatchViews()
    }
    
    private func setupLayout() {
        view.addSubview(leagueView)
        view.addSubview(contentStackView)
        
        leagueView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.equalTo(leagueView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
    }
    
    private func configureLeague() {
        leagueView.configure(
            leagueLogo: league.name,
            countryName: league.country?.name ?? "",
            leagueName: league.name
        )
    }

    private func setupMatchViews() {
        matches.sort { $0.startTimestamp < $1.startTimestamp }
        
        matches.forEach { match in
            let matchView = MatchView()
            
            matchView.updateHomeLogo(homeTeam: match.homeTeamLogo)
            matchView.updateAwayLogo(awayTeam: match.awayTeamLogo)
            matchView.setMatch(homeTeamName: match.homeTeam.name,
                               awayTeamName: match.awayTeam.name,
                               matchTime: match.dataFormat)
            
            configureMatchStatus(matchView, match: match)
            
            contentStackView.addArrangedSubview(matchView)
            
            
        }
    }
    
    private func configureMatchStatus(_ matchView: MatchView, match: Event) {
        switch match.status {
        case .notStarted:
            matchView.updateTime(time: AppStrings.notStarted)
        case .inProgress:
            matchView.updateScore(homeScore: match.getHomeTeamScore, awayScore: match.getAwayTeamScore)
            matchView.isLive()
            matchView.updateTime(time: "\(match.timeDifference)'")
        case .halftime:
            matchView.updateScore(homeScore: match.getHomeTeamScore, awayScore: match.getAwayTeamScore)
            matchView.isLive()
            matchView.updateTime(time: AppStrings.halftime)
        case .finished:
            matchView.updateScore(homeScore: match.getHomeTeamScore, awayScore: match.getAwayTeamScore )
            if match.getHomeTeamScore > match.getAwayTeamScore {
                matchView.firstWinner()
            } else if match.getHomeTeamScore < match.getAwayTeamScore {
                matchView.secondWinner()
            } else {
                matchView.draw()
            }
            matchView.updateTime(time: AppStrings.finished)
        }
    }
}


#Preview {
    ViewController()
}
