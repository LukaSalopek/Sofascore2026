//
//  SettingsVC.swift
//  Zadatak3
//
//  Created by akademija on 29.03.2026..
//


import UIKit
import SnapKit

class SettingsVC : UIViewController {
    private var settingsView = SettingsView()
    private var backgroundFill = UIView()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
    }
    
    private func setupNavBar(){
        view.addSubview(settingsView)
        settingsView.backgroundColor = .sofaBlue
        settingsView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        settingsView.onBackTap = { [weak self] in
            self?.dismissButton()
        }
        
        view.addSubview(backgroundFill)
        backgroundFill.backgroundColor = .sofaBlue
        backgroundFill.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(settingsView.snp.top)
        }
        
        
    }
    
    @objc func dismissButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
}
#Preview{
    SettingsVC()
}


