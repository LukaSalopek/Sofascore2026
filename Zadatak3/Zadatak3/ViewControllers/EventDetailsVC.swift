//
//  EventDetailsVC.swift
//  Zadatak3
//

import UIKit
import SnapKit
import SofaAcademic

class EventDetailsVC: UIViewController {

    private let match: Event
    private let sport: String

    private let header = EventDetailsHeader()
    private let matchView = EventDetailsView()
    private let tableView = UITableView()
    private let emptyView = IncidentsEmptyView()

    private var rows: [IncidentRow] = []

    init(match: Event, sportName: String) {
        self.match = match
        self.sport = sportName

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .sofaEventDetailsBackground

        header.backgroundColor = .white
        matchView.backgroundColor = .white

        view.addSubview(matchView)
        view.addSubview(tableView)

        setupTableView()
        setupHeader()
        setupConstraints()

        let displayModel = EventDetailsMapper.map(match: match)
        matchView.configure(with: displayModel)
        emptyView.setShowsTournamentButton(match.status == .notStarted)

        Task {
            let homeLogo = await APIClient.shared.fetchImage(
                from: displayModel.homeTeamLogoURL
            )

            let awayLogo = await APIClient.shared.fetchImage(
                from: displayModel.awayTeamLogoURL
            )

            await MainActor.run {
                self.matchView.updateLogos(
                    homeLogo: homeLogo ?? UIImage(),
                    awayLogo: awayLogo ?? UIImage()
                )
            }
        }
        loadIncidents()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.backgroundColor = .sofaEventDetailsBackground
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 56
        tableView.showsVerticalScrollIndicator = false

        tableView.register(GoalIncidentCell.self, forCellReuseIdentifier: GoalIncidentCell.reuseIdentifier)
        tableView.register(FoulIncidentCell.self, forCellReuseIdentifier: FoulIncidentCell.reuseIdentifier)
        tableView.register(PeriodIncidentCell.self, forCellReuseIdentifier: PeriodIncidentCell.reuseIdentifier)
    }

    private func setupHeader() {
        view.addSubview(header)

        header.isBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }

        Task {
            let image = await APIClient.shared.fetchImage(
                from: match.league?.logoUrl
            )

            DispatchQueue.main.async { [weak self] in
                self?.header.configure(
                    leagueLogo: image ?? UIImage(),
                    sport: self?.sport ?? "",
                    country: self?.match.league?.country?.name ?? "",
                    leagueName: self?.match.league?.name ?? "",
                    round: self?.match.round
                )
            }
        }
    }

    private func setupConstraints() {
        header.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }

        matchView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(header.snp.bottom)
        }

        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(matchView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
    }

    private func loadIncidents(){
        Task {
            do {
                let incidents = try await APIClient.shared.fetchIncidents(eventId: match.id)
                await MainActor.run {
                    self.rows = IncidentMapper.makeRows(from: incidents, sport: self.sport)
                    self.tableView.backgroundView = self.rows.isEmpty ? self.emptyView : nil
                    self.tableView.reloadData()
                }
            } catch {
                print("incidents fetch failed : \(error)")
            }
        }
    }
}

extension EventDetailsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch rows[indexPath.row] {
        case .goal(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: GoalIncidentCell.reuseIdentifier, for: indexPath) as! GoalIncidentCell
            cell.configure(with: model)
            return cell

        case .foul(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: FoulIncidentCell.reuseIdentifier, for: indexPath) as! FoulIncidentCell
            cell.configure(with: model)
            return cell

        case .period(let title):
            let cell = tableView.dequeueReusableCell(withIdentifier: PeriodIncidentCell.reuseIdentifier, for: indexPath) as! PeriodIncidentCell
            cell.configure(title: title)
            return cell
        }
    }
}
