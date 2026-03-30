import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController {
    
    private var sportSelectorMenuStack = UIStackView()
    private let selectionIndicator = UIView()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private var sports = SportSelectorMenuModel.sportSelectorMenuData
    private var sections: [Section] = []
    private let eventService = EventService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .sofaBlue
        
        setupSportSelector()
        setupIndicator()
        setupTableView()
        loadData(shouldShowData: true)
    }
    
    private func setupSportSelector() {
        view.addSubview(sportSelectorMenuStack)
        sportSelectorMenuStack.axis = .horizontal
        sportSelectorMenuStack.distribution = .fillEqually
        sportSelectorMenuStack.backgroundColor = .sofaBlue
        
        sportSelectorMenuStack.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        sports.enumerated().forEach { index, sport in
            let sportView = SportSelectorMenu()
            sportView.setSports(sportName: sport.sportName, sportImage: sport.sportImage)
            sportView.onTap = { [weak self] in
                self?.handleSportSelection(at: index, targetView: sportView)
            }
            sportSelectorMenuStack.addArrangedSubview(sportView)
        }
    }
    
    private func setupIndicator() {
        selectionIndicator.backgroundColor = .white
        selectionIndicator.layer.cornerRadius = 2
        selectionIndicator.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.addSubview(selectionIndicator)
        
        guard let firstCell = sportSelectorMenuStack.arrangedSubviews.first else {
            return
        }
        
        selectionIndicator.snp.makeConstraints{
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
        
        tableView.register(MatchTableViewCell.self, forCellReuseIdentifier: "MatchCell")
        tableView.register(LeagueHeaderView.self, forHeaderFooterViewReuseIdentifier: "LeagueHeader")
        
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(sportSelectorMenuStack.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func loadData(shouldShowData: Bool = true) {
        if shouldShowData {
            self.sections = eventService.getGroupedEvents()
        } else {
            self.sections = []
        }
        tableView.reloadData()
    }

    private func handleSportSelection(at index: Int, targetView: UIView) {
        selectionIndicator.snp.remakeConstraints{
            $0.bottom.equalTo(sportSelectorMenuStack.snp.bottom)
            $0.height.equalTo(4)
            $0.centerX.equalTo(targetView.snp.centerX)
            $0.leading.trailing.equalTo(targetView).inset(8)
        }
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        loadData(shouldShowData: index == 0)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.reuseIdentifier, for: indexPath) as? MatchTableViewCell {
            if sections.indices.contains(indexPath.section) {
                let section = sections[indexPath.section]
                if section.events.indices.contains(indexPath.row) {
                    let match = section.events[indexPath.row]
                    cell.configure(with: match)
                }
            }
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: LeagueHeaderView.reuseIdentifier) as? LeagueHeaderView {
            if sections.indices.contains(section) {
                let league = sections[section].league
                header.configure(with: league)
            }
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == sections.count - 1 {
            return 0
        }
        return 8
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
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
}

#Preview{
    ViewController()
}
