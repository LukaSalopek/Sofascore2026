//
//  LoginVC.swift
//  Zadatak3
//
//  Created by akademija on 24.05.2026..
//

import UIKit
import SnapKit

class LoginVC: UIViewController {
    
    private let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupActions()
    }
    
    private func setupView() {
        view.addSubview(loginView)
        loginView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupActions() {
        loginView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func loginTapped() {
        guard let username = loginView.usernameField.text, !username.isEmpty,
              let password = loginView.passwordField.text, !password.isEmpty else {
            loginView.showError("Please enter username and password")
            return
        }
        
        loginView.hideError()
        loginView.showLoading()
        
        Task {
            do {
                let response = try await APIClient.shared.login(username: username, password: password)
                AuthManager.shared.saveToken(response.token, userName: response.name)
                
                await MainActor.run {
                    guard let window = UIApplication.shared.windows.first else { return }
                    
                    let viewController = ViewController()
                    let navigationController = UINavigationController(rootViewController: viewController)
                    
                    window.rootViewController = navigationController
                    window.makeKeyAndVisible()
                }
            } catch {
                await MainActor.run {
                    loginView.hideLoading()
                    loginView.showError("Login failed: \(error.localizedDescription)")
                }
            }
        }
    }
}
