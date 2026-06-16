//
//  SettingsVC.swift
//  Zadatak3
//
//  Created by akademija on 29.03.2026..
//

import UIKit
import SnapKit

class SettingsVC: UIViewController {
    
    private let settingsView = SettingsView()
    private let backgroundFill = UIView()
    
    private let userInfoLabel = UILabel()
    private let eventCountLabel = UILabel()
    private let leagueCountLabel = UILabel()
    private let logoutButton = UIButton(type: .system)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        updateStats()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHeader()
        setupViews()
        setupConstraints()
    }
    
    private func updateStats() {
        let eventCount = DatabaseManager.shared.getEventCount()
        let leagueCount = DatabaseManager.shared.getLeagueCount()
        eventCountLabel.text = "Events in database: \(eventCount)"
        leagueCountLabel.text = "Leagues in database: \(leagueCount)"
    }
    
    private func setupViews() {
        if let userName = AuthManager.shared.getUserName() {
            userInfoLabel.text = "Logged in as: \(userName)"
        } else {
            userInfoLabel.text = "Logged in as: Unknown"
        }
        userInfoLabel.font = .systemFont(ofSize: 16)
        userInfoLabel.textColor = .darkText
        userInfoLabel.textAlignment = .center
        
        eventCountLabel.font = .systemFont(ofSize: 14)
        eventCountLabel.textColor = .darkGray
        eventCountLabel.textAlignment = .center
        
        leagueCountLabel.font = .systemFont(ofSize: 14)
        leagueCountLabel.textColor = .darkGray
        leagueCountLabel.textAlignment = .center

        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.backgroundColor = .sofaLiveRed
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.layer.cornerRadius = 8
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        
        view.addSubview(userInfoLabel)
        view.addSubview(eventCountLabel)
        view.addSubview(leagueCountLabel)
        view.addSubview(logoutButton)
    }
    
    private func setupConstraints() {
        settingsView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        backgroundFill.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(settingsView.snp.top)
        }
        
        userInfoLabel.snp.makeConstraints {
            $0.top.equalTo(settingsView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        eventCountLabel.snp.makeConstraints {
            $0.top.equalTo(userInfoLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        leagueCountLabel.snp.makeConstraints {
            $0.top.equalTo(eventCountLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(leagueCountLabel.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(44)
        }
    }
    
    private func setupHeader() {
        view.addSubview(settingsView)
        settingsView.backgroundColor = .sofaBlue
        
        settingsView.onBackTap = { [weak self] in
            self?.dismissButton()
        }
        
        view.addSubview(backgroundFill)
        backgroundFill.backgroundColor = .sofaBlue
    }
    
    private func dismissButton() {
        dismiss(animated: true)
    }
    
    @objc private func logoutTapped() {
        AuthManager.shared.logout()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let loginVC = LoginVC()
        let navController = UINavigationController(rootViewController: loginVC)
        appDelegate.window?.rootViewController = navController
        appDelegate.window?.makeKeyAndVisible()
    }
}

#Preview {
    SettingsVC()
}
