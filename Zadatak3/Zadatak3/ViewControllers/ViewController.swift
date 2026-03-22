import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController {
    
    private var sportSelectorMenuStack = UIStackView()
    private let selectionIndicator = UIView()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    
    private var sports = SportSelectorMenuData
    private var sections: [Section] = []
    private let eventService = EventService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 55/255, green: 77/255, blue: 245/255, alpha: 1.0)
        
        setupSportSelector()
        setupIndicator()
        setupTableView()
        loadData()
    }
    
    
    private func setupSportSelector() {
        view.addSubview(sportSelectorMenuStack)
        sportSelectorMenuStack.axis = .horizontal
        sportSelectorMenuStack.distribution = .fillEqually
        sportSelectorMenuStack.backgroundColor = UIColor(red: 55/255, green: 77/255, blue: 245/255, alpha: 1.0)
        
        sportSelectorMenuStack.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        sports.enumerated().forEach { index, sport in
            let sportView = SportSelectorMenuCell()
            sportView.setSports(sportName: sport.sportName, sportImage: sport.sportImage)
            sportView.onSelected = { [weak self] in
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
        
        let firstCell = sportSelectorMenuStack.arrangedSubviews[0]
        
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

    private func loadData() {
        self.sections = eventService.getGroupedEvents()
        tableView.reloadData()
    }

    private func handleSportSelection(at index: Int, targetView: UIView) {
            selectionIndicator.snp.remakeConstraints{
                $0.bottom.equalTo(sportSelectorMenuStack.snp.bottom)
                $0.height.equalTo(4)
                $0.centerX.equalTo(targetView.snp.centerX)
                $0.leading.trailing.equalTo(targetView).inset(8)
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as! MatchTableViewCell
        let match = sections[indexPath.section].events[indexPath.row]
        
        cell.configure(with: match)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "LeagueHeader") as! LeagueHeaderView
        let league = sections[section].league
        header.leagueView.configure(
            leagueLogo: league.name,
            countryName: league.country?.name ?? "",
            leagueName: league.name
        )
        return header
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
