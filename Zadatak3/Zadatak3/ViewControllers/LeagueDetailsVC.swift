//
//  LeagueDetailsVC.swift
//  Zadatak3
//

import UIKit
import SnapKit
import SofaAcademic

class LeagueDetailsVC: UIViewController {

    private let league: League
    private let sport: String

    private let header = LeagueDetailsHeader()
    private let matchesTableView = UITableView(frame: .zero, style: .plain)
    private let standingsTableView = UITableView(frame: .zero, style: .plain)

    private let service = LeagueService()

    private var roundSections: [RoundSection] = []
    private var standings: [Standings] = []
    private var imageCache: [String: UIImage] = [:]

    private lazy var standingsColumns = StandingsColumn.columns(for: sport)

    init(league: League, sportName: String) {
        self.league = league
        self.sport = sportName
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .sofaBlue

        setupHeader()
        setupTables()
        setupConstraints()

        header.selectTab(.matches, animated: false)
        showTab(.matches)

        loadMatches()
        loadStandings()
    }

    private func setupHeader() {
        view.addSubview(header)

        header.onBack = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }

        header.onTabChange = { [weak self] tab in
            self?.showTab(tab)
        }

        header.configure(
            logo: UIImage(),
            name: league.name,
            country: league.country?.name ?? ""
        )

        Task { @MainActor in
            let image = await APIClient.shared.fetchImage(from: league.logoUrl)
            self.header.configure(
                logo: image ?? UIImage(),
                name: self.league.name,
                country: self.league.country?.name ?? ""
            )
        }
    }

    private func setupTables() {
        view.addSubview(matchesTableView)
        view.addSubview(standingsTableView)

        matchesTableView.dataSource = self
        matchesTableView.delegate = self
        matchesTableView.backgroundColor = .white
        matchesTableView.separatorStyle = .none
        matchesTableView.sectionHeaderTopPadding = 0
        matchesTableView.sectionHeaderHeight = UITableView.automaticDimension
        matchesTableView.estimatedSectionHeaderHeight = 44
        matchesTableView.register(MatchTableViewCell.self, forCellReuseIdentifier: MatchTableViewCell.reuseIdentifier)
        matchesTableView.register(RoundHeaderView.self, forHeaderFooterViewReuseIdentifier: RoundHeaderView.reuseIdentifier)

        standingsTableView.dataSource = self
        standingsTableView.delegate = self
        standingsTableView.backgroundColor = .white
        standingsTableView.separatorStyle = .singleLine
        standingsTableView.sectionHeaderTopPadding = 0
        standingsTableView.sectionHeaderHeight = UITableView.automaticDimension
        standingsTableView.estimatedSectionHeaderHeight = 44
        standingsTableView.register(StandingsCell.self, forCellReuseIdentifier: StandingsCell.reuseIdentifier)
        standingsTableView.register(StandingsHeaderView.self, forHeaderFooterViewReuseIdentifier: StandingsHeaderView.reuseIdentifier)
    }

    private func setupConstraints() {
        header.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }

        matchesTableView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        standingsTableView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func showTab(_ tab: LeagueDetailsHeader.Tab) {
        matchesTableView.isHidden = (tab != .matches)
        standingsTableView.isHidden = (tab != .standings)
    }

    private func loadMatches() {
        Task { @MainActor in
            do {
                roundSections = try await service.getMatchesGroupedByRound(leagueId: league.id)
                matchesTableView.reloadData()

                let urls = roundSections
                    .flatMap { $0.events }
                    .flatMap { [$0.homeTeam.logoUrl, $0.awayTeam.logoUrl] }
                    .compactMap { $0 }

                preloadLogos(urls) { [weak self] in
                    self?.matchesTableView.reloadData()
                }
            } catch {
                print("❌ loadMatches error: \(error)")
            }
        }
    }

    private func loadStandings() {
        Task { @MainActor in
            do {
                standings = try await service.getStandings(leagueId: league.id)
                standingsTableView.reloadData()
            } catch {
                print("❌ loadStandings error: \(error)")
            }
        }
    }

    private func preloadLogos(_ urls: [String], then reload: @escaping () -> Void) {
        Task { @MainActor in
            await withTaskGroup(of: (String, UIImage?).self) { group in
                for url in Set(urls) where imageCache[url] == nil {
                    group.addTask { (url, await APIClient.shared.fetchImage(from: url)) }
                }
                for await (url, image) in group {
                    if let image { imageCache[url] = image }
                }
            }
            reload()
        }
    }

    private func cachedImage(for urlString: String?) -> UIImage {
        guard let urlString, let image = imageCache[urlString] else {
            return UIImage()
        }
        return image
    }
}

extension LeagueDetailsVC: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        tableView == matchesTableView ? roundSections.count : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView == matchesTableView ? roundSections[section].events.count : standings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == matchesTableView {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MatchTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? MatchTableViewCell else {
                return UITableViewCell()
            }

            let match = roundSections[indexPath.section].events[indexPath.row]
            cell.configure(
                with: match,
                homeLogo: cachedImage(for: match.homeTeam.logoUrl),
                awayLogo: cachedImage(for: match.awayTeam.logoUrl)
            )
            return cell
        }

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: StandingsCell.reuseIdentifier,
            for: indexPath
        ) as? StandingsCell else {
            return UITableViewCell()
        }

        let row = standings[indexPath.row]
        cell.configure(with: row, columns: standingsColumns)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == matchesTableView {
            guard let header = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: RoundHeaderView.reuseIdentifier
            ) as? RoundHeaderView else {
                return nil
            }
            header.configure(round: roundSections[section].round)
            return header
        }

        guard let standingsHeader = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: StandingsHeaderView.reuseIdentifier
        ) as? StandingsHeaderView else {
            return nil
        }
        standingsHeader.configure(columns: standingsColumns)
        return standingsHeader
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView == matchesTableView else { return }

        let match = roundSections[indexPath.section].events[indexPath.row]
        let detailsVC = EventDetailsVC(match: match, sportName: sport)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
