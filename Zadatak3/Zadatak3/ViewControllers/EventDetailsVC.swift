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
    
    private let contentView = EventDetailsView()
    private let header = EventDetailsHeader()

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
        
        view.backgroundColor = .white
        
        view.addSubview(contentView)
        
        setupHeader()
        setupConstraints()
        
        let displayModel = EventDetailsMapper.map(match: match)
        
        contentView.configure(with: displayModel)
        
        Task {
            let homeLogo = await APIClient.shared.fetchImage(
                from: displayModel.homeTeamLogoURL
            )
            
            let awayLogo = await APIClient.shared.fetchImage(
                from: displayModel.awayTeamLogoURL
            )
            
            await MainActor.run {
                self.contentView.updateLogos(
                    homeLogo: homeLogo ?? UIImage(),
                    awayLogo: awayLogo ?? UIImage()
                )
            }
        }
        loadIncidents()
    }
    
    
    private func setupHeader() {
        header.backgroundColor = .white
        
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
                    leagueName: self?.match.league?.name ?? ""
                )
            }
        }
    }

    private func setupConstraints() {
        header.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(header.snp.bottom)
        }
    }
    
    private func loadIncidents(){
        Task {
            do {
                let incidents = try await APIClient.shared.fetchIncidents(eventId: match.id)
                await MainActor.run{
                    let views = IncidentViewHelper.makeViews(from: incidents, sport: self.sport)
                    self.contentView.setIncidents(views)
                }
            } catch {
                print("incidents fetch failed : \(error)")
            }
        }
    }
}
