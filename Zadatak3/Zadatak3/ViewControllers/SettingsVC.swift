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
    private let logoutButton = UIButton(type: .system)
    
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
        view.backgroundColor = .white
        setupHeader()
        setupViews()
        setupConstraints()
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

        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.backgroundColor = .sofaLiveRed
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.layer.cornerRadius = 8
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        
        view.addSubview(userInfoLabel)
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
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(userInfoLabel.snp.bottom).offset(32)
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
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.checkAuthAndSetRoot()
        }
    }
}

#Preview {
    SettingsVC()
}
