import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController {

    private let header = HeaderView()
    private var sportSelectorMenuStack = UIStackView()
    private let selectionIndicator = UIView()
    private let tableView = UITableView(frame: .zero, style: .plain)

    private var currentSportName: String = "Football"

    private var sports = SportSelectorMenuModel.sportSelectorMenuData
    private var sections: [Section] = []

    private let eventService = EventService()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .sofaBlue

        setupHeader()
        setupSportSelector()
        setupIndicator()
        setupTableView()

        loadData(sport: "football")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(
            true,
            animated: animated
        )
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(
            false,
            animated: animated
        )
    }

    private func setupHeader() {

        view.addSubview(header)

        header.backgroundColor = .sofaBlue

        header.onSettingsTap = { [weak self] in
            self?.showSettings()
        }

        header.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func showSettings() {

        let settingsVC = SettingsVC()

        settingsVC.modalPresentationStyle = .fullScreen

        present(settingsVC, animated: true)
    }

    private func setupSportSelector() {

        view.addSubview(sportSelectorMenuStack)

        sportSelectorMenuStack.axis = .horizontal
        sportSelectorMenuStack.distribution = .fillEqually
        sportSelectorMenuStack.backgroundColor = .sofaBlue

        sportSelectorMenuStack.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }

        sports.enumerated().forEach { index, sport in

            let sportView = SportSelectorMenu()

            sportView.setSports(
                sportName: sport.sportName,
                sportImage: sport.sportImage
            )

            sportView.onTap = { [weak self] in
                self?.handleSportSelection(
                    at: index,
                    targetView: sportView
                )
            }

            sportSelectorMenuStack.addArrangedSubview(sportView)
        }
    }

    private func setupIndicator() {

        selectionIndicator.backgroundColor = .white
        selectionIndicator.layer.cornerRadius = 2

        selectionIndicator.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]

        view.addSubview(selectionIndicator)

        guard let firstCell =
                sportSelectorMenuStack.arrangedSubviews.first else {
            return
        }

        selectionIndicator.snp.makeConstraints {
            $0.bottom.equalTo(sportSelectorMenuStack.snp.bottom)
            $0.centerX.equalTo(firstCell.snp.centerX)
            $0.height.equalTo(4)
            $0.leading.trailing.equalTo(firstCell).inset(8)
        }
    }

    private func setupTableView() {

        view.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 56

        tableView.register(
            MatchTableViewCell.self,
            forCellReuseIdentifier: MatchTableViewCell.reuseIdentifier
        )

        tableView.register(
            LeagueHeaderView.self,
            forHeaderFooterViewReuseIdentifier:
                LeagueHeaderView.reuseIdentifier
        )

        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0

        tableView.snp.makeConstraints {
            $0.top.equalTo(sportSelectorMenuStack.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func loadData(sport: String) {

        Task {

            do {

                let sections = try await eventService
                    .getGroupedEvents(sport: sport)

                self.sections = sections

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            } catch {
                print(error)
            }
        }
    }

    private func handleSportSelection(
        at index: Int,
        targetView: UIView
    ) {

        selectionIndicator.snp.remakeConstraints {
            $0.bottom.equalTo(sportSelectorMenuStack.snp.bottom)
            $0.height.equalTo(4)
            $0.centerX.equalTo(targetView.snp.centerX)
            $0.leading.trailing.equalTo(targetView).inset(8)
        }

        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: .curveEaseIn
        ) {
            self.view.layoutIfNeeded()
        }

        let selectedSport = sports[index]

        currentSportName = selectedSport.sportName

        loadData(sport: selectedSport.slug)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        sections.count
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        sections[section].events.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MatchTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? MatchTableViewCell else {
            return UITableViewCell()
        }

        let match = sections[indexPath.section]
            .events[indexPath.row]

        cell.configure(with: match)

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {

        guard let header =
                tableView.dequeueReusableHeaderFooterView(
                    withIdentifier:
                        LeagueHeaderView.reuseIdentifier
                ) as? LeagueHeaderView else {
            return nil
        }

        header.configure(
            with: sections[section].league
        )

        return header
    }

    func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {

        section == sections.count - 1 ? 0 : 8
    }

    func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {

        let footerView = UIView()

        footerView.backgroundColor = .clear

        let line = UIView()

        line.backgroundColor = .lightGray

        footerView.addSubview(line)

        line.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }

        return footerView
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        let match = sections[indexPath.section]
            .events[indexPath.row]

        let detailsVC = EventDetailsVC(
            match: match,
            sportName: currentSportName
        )

        navigationController?.pushViewController(
            detailsVC,
            animated: true
        )
    }
}

#Preview {
    ViewController()
}
