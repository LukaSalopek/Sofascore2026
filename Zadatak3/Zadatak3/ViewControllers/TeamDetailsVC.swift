//
//  TeamDetailsVC.swift
//  Zadatak3
//

import UIKit
import SnapKit

class TeamDetailsVC: UIViewController {

    private let team: Team

    private let header = TeamDetailsHeader()
    private let detailsView = TeamDetailsView()
    private let squadTableView = UITableView(frame: .zero, style: .plain)

    private var coach: TeamManager?
    private var players: [Player] = []

    private let imageLoader: ImageLoader = { url, completion in
        Task { @MainActor in
            completion(await APIClient.shared.fetchImage(from: url))
        }
    }

    init(team: Team) {
        self.team = team
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
        setupContent()
        setupConstraints()

        header.selectTab(.details, animated: false)
        showTab(.details)

        loadData()
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
            name: team.name,
            country: team.country?.name ?? ""
        )

        Task { @MainActor in
            let image = await APIClient.shared.fetchImage(from: team.logoUrl)
            self.header.configure(
                logo: image ?? UIImage(),
                name: self.team.name,
                country: self.team.country?.name ?? ""
            )
        }
    }

    private func setupContent() {
        detailsView.imageLoader = imageLoader

        squadTableView.dataSource = self
        squadTableView.delegate = self
        squadTableView.backgroundColor = .white
        squadTableView.separatorStyle = .none
        squadTableView.showsVerticalScrollIndicator = false
        squadTableView.showsHorizontalScrollIndicator = false
        squadTableView.automaticallyAdjustsScrollIndicatorInsets = false
        squadTableView.sectionHeaderTopPadding = 0
        squadTableView.sectionHeaderHeight = UITableView.automaticDimension
        squadTableView.estimatedSectionHeaderHeight = 32
        squadTableView.rowHeight = 64
        squadTableView.register(PlayerCell.self, forCellReuseIdentifier: PlayerCell.reuseIdentifier)

        view.addSubview(detailsView)
        view.addSubview(squadTableView)
    }

    private func setupConstraints() {
        header.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }

        [detailsView, squadTableView].forEach { content in
            content.snp.makeConstraints {
                $0.top.equalTo(header.snp.bottom)
                $0.leading.trailing.bottom.equalToSuperview()
            }
        }
    }

    private func showTab(_ tab: TeamDetailsHeader.Tab) {
        detailsView.isHidden = (tab != .details)
        squadTableView.isHidden = (tab != .squad)
    }

    private func loadData() {
        Task { @MainActor in
            async let infoTask = fetchInfo()
            async let playersTask = fetchPlayers()
            async let tournamentsTask = fetchTournaments()

            let info = await infoTask
            let players = await playersTask
            let tournaments = await tournamentsTask

            self.coach = info?.manager
            self.players = players
            if let country = info?.team.country?.name {
                self.header.setCountry(country)
            }
            self.detailsView.configure(info: info, players: players, tournaments: tournaments)
            self.squadTableView.reloadData()
        }
    }

    private func fetchInfo() async -> TeamInfo? {
        do {
            return try await APIClient.shared.fetchTeamInfo(teamId: team.id)
        } catch {
            print("❌ team info (\(team.id)): \(error)")
            return nil
        }
    }

    private func fetchPlayers() async -> [Player] {
        do {
            return try await APIClient.shared.fetchTeamPlayers(teamId: team.id)
        } catch {
            print("❌ team players (\(team.id)): \(error)")
            return []
        }
    }

    private func fetchTournaments() async -> [League] {
        do {
            return try await APIClient.shared.fetchTeamTournaments(teamId: team.id)
        } catch {
            print("❌ team tournaments (\(team.id)): \(error)")
            return []
        }
    }
}

extension TeamDetailsVC: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : players.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isSectionEmpty(section) { return nil }

        let container = UIView()
        container.backgroundColor = .white

        let label = UILabel()
        label.text = section == 0 ? "Coach" : "Players"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .sofaGray

        container.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-4)
        }
        return container
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        isSectionEmpty(section) ? 0 : UITableView.automaticDimension
    }

    private func isSectionEmpty(_ section: Int) -> Bool {
        section == 1 && players.isEmpty
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PlayerCell.reuseIdentifier,
            for: indexPath
        ) as? PlayerCell else {
            return UITableViewCell()
        }

        if indexPath.section == 0 {
            cell.configure(name: coach?.name ?? "-", country: coach?.country?.name, imageUrl: coach?.imageUrl, imageLoader: imageLoader)
        } else {
            let player = players[indexPath.row]
            cell.configure(name: player.name, country: player.country?.name, imageUrl: player.imageUrl, imageLoader: imageLoader)
        }
        return cell
    }
}
