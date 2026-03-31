//
//  EventDetailsVC.swift
//  Zadatak3
//
//  Created by akademija on 29.03.2026..
//

import UIKit
import SnapKit
import SofaAcademic

class EventDetailsVC: UIViewController {
    private var match: Event
    private let contentView = EventDetailsView()
    private let header = EventDetailsHeader()

    init(match: Event) {
        self.match = match
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

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
        setupView()
        contentView.configure(with: match)
        
    }
    
    private func setupView(){
        header.backgroundColor = .white
        view.addSubview(header)
        
        header.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        header.isBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(header.snp.bottom)
        }
    }
    
}
