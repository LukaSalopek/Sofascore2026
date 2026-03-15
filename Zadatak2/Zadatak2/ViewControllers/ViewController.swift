import UIKit
import SofaAcademic
import SnapKit

class ViewController: UIViewController {
    
    private var leagueView = LeagueView()
    private let data = Homework2DataSource()
    lazy var matches = data.laLigaEvents()
    lazy var league = data.laLigaLeague()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLeague()
        configureLeague()
        setupMatchViews()
    }
    
    func setupLeague() {
        view.addSubview(leagueView)
        leagueView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(56)
        }
    }
    
    func configureLeague() {
        leagueView.configure(
            leagueLogo: league.name,
            countryName: league.country?.name ?? "",
            leagueName: league.name
        )
    }
    
    func setupMatchViews() {
        var previousView: UIView = leagueView
        matches.sort{ $0.startTimestamp < $1.startTimestamp}
        matches.forEach { match in
            let matchView = MatchView()
            view.addSubview(matchView)
            
            matchView.updateHomeLogo(firstLogo: match.homeTeam.name)
            matchView.updateAwayLogo(secondLogo: match.awayTeam.name)
            
            let date = Date(timeIntervalSince1970: TimeInterval(match.startTimestamp))
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let time = formatter.string(from: date)
            matchView.setMatch(firstName: match.homeTeam.name, secondName: match.awayTeam.name, matchTime: time)
            
            switch match.status {
            case .notStarted:
                matchView.updateTime(time: AppStrings.notStarted)
            case .inProgress:
                matchView.updateScore(firstScore: match.homeScore!, secondScore: match.awayScore!)
                matchView.isLive()
                let diff = Int(Date().timeIntervalSince(date) / 60)
                matchView.updateTime(time: "\(diff)'")
            case .halftime:
                matchView.updateScore(firstScore: match.homeScore!, secondScore: match.awayScore!)
                matchView.isLive()
                matchView.updateTime(time: AppStrings.halftime)
            case .finished:
                matchView.updateScore(firstScore: match.homeScore!, secondScore: match.awayScore!)
                if match.homeScore! > match.awayScore! {
                    matchView.firstWinner()
                } else if match.homeScore! < match.awayScore! {
                    matchView.secondWinner()
                } else {
                    matchView.draw()
                }
                matchView.updateTime(time: AppStrings.finished)
            }
            
            matchView.snp.makeConstraints {
                $0.leading.equalToSuperview()
                $0.left.right.equalToSuperview().inset(10)
                $0.top.equalTo(previousView.snp.bottom).offset(10)
                $0.height.equalTo(35)
            }
            previousView = matchView
        }
    }
}

#Preview {
    ViewController()
}
