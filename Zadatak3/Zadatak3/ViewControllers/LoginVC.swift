//
//  LoginVC.swift
//  Zadatak3
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
                let saved = AuthManager.shared.saveToken(response.token, userName: response.name)
                
                if !saved {
                    await MainActor.run {
                        loginView.hideLoading()
                        loginView.showError("Failed to save login data")
                    }
                    return
                }
                
                await MainActor.run {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let viewController = ViewController()
                    let navController = UINavigationController(rootViewController: viewController)
                    appDelegate.window?.rootViewController = navController
                    appDelegate.window?.makeKeyAndVisible()
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
