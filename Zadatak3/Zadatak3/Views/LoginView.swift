//
//  LoginView.swift
//  Zadatak3
//
//  Created by akademija on 24.05.2026..
//

import UIKit
import SnapKit
import SofaAcademic

class LoginView: BaseView {
    
    let usernameField = UITextField()
    let passwordField = UITextField()
    let loginButton = UIButton(type: .system)
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    let errorLabel = UILabel()
    
    override func addViews() {
        addSubview(usernameField)
        addSubview(passwordField)
        addSubview(loginButton)
        addSubview(activityIndicator)
        addSubview(errorLabel)
    }
    
    override func styleViews() {
        usernameField.placeholder = "Username"
        usernameField.borderStyle = .roundedRect
        usernameField.autocapitalizationType = .none
        
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.borderStyle = .roundedRect
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .sofaBlue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 8
        
        activityIndicator.hidesWhenStopped = true
        
        errorLabel.textColor = .red
        errorLabel.font = .systemFont(ofSize: 14)
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
    }
    
    override func setupConstraints() {
        usernameField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-60)
            $0.width.equalTo(260)
            $0.height.equalTo(44)
        }
        
        passwordField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(usernameField.snp.bottom).offset(16)
            $0.width.equalTo(260)
            $0.height.equalTo(44)
        }
        
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordField.snp.bottom).offset(24)
            $0.width.equalTo(120)
            $0.height.equalTo(44)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(16)
        }
        
        errorLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(activityIndicator.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    func hideError() {
        errorLabel.isHidden = true
    }
    
    func showLoading() {
        loginButton.isEnabled = false
        loginButton.alpha = 0.6
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        loginButton.isEnabled = true
        loginButton.alpha = 1.0
        activityIndicator.stopAnimating()
    }
}
