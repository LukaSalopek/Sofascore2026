//
//  ViewController.swift
//  Zadatak3
//
//  Created by akademija on 18.03.2026..
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private var SportSelectorMenuStack = UIStackView()
    private var sports = SportSelectorMenuData
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
    }

    private func setupLayout() {
        view.addSubview(SportSelectorMenuStack)
        
        SportSelectorMenuStack.axis = .horizontal
        SportSelectorMenuStack.distribution = .fillEqually
        
        SportSelectorMenuStack.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()

        }

        sports.forEach { sport in
            let sportView = SportSelectorMenuCell()
            sportView.backgroundColor = UIColor(red: 55/255, green: 77/255, blue: 245/255, alpha: 1.0)
            sportView.setSports(sportName: sport.sportName, sportImage: sport.sportImage)
            SportSelectorMenuStack.addArrangedSubview(sportView)
        }
    }

}

#Preview{
    ViewController()
}
