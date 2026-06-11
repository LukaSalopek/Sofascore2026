//
//  LeagueDetailsHeader.swift
//  Zadatak3
//

import UIKit
import SnapKit
import SofaAcademic

class LeagueDetailsHeader: BaseView {

    enum Tab: Int { case matches, standings }

    private let backButton = UIImageView()
    private let logoContainer = UIView()
    private let leagueLogo = UIImageView()
    private let nameLabel = UILabel()
    private let countryLabel = UILabel()

    private let tabsStack = UIStackView()
    private let matchesButton = UIButton(type: .system)
    private let standingsButton = UIButton(type: .system)
    private let indicator = UIView()

    var onBack: (() -> Void)?
    var onTabChange: ((Tab) -> Void)?

    override func addViews() {
        addSubview(backButton)
        addSubview(logoContainer)
        logoContainer.addSubview(leagueLogo)
        addSubview(nameLabel)
        addSubview(countryLabel)
        addSubview(tabsStack)
        tabsStack.addArrangedSubview(matchesButton)
        tabsStack.addArrangedSubview(standingsButton)
        addSubview(indicator)
    }

    override func styleViews() {
        backgroundColor = .sofaBlue

        backButton.image = UIImage(named: "back")?.withRenderingMode(.alwaysTemplate)
        backButton.tintColor = .white
        backButton.isUserInteractionEnabled = true

        logoContainer.backgroundColor = .white
        logoContainer.layer.cornerRadius = 8
        logoContainer.clipsToBounds = true

        leagueLogo.contentMode = .scaleAspectFit

        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        nameLabel.textColor = .white

        countryLabel.font = .systemFont(ofSize: 14, weight: .bold)
        countryLabel.textColor = .white

        tabsStack.axis = .horizontal
        tabsStack.distribution = .fillEqually

        matchesButton.setTitle("Matches", for: .normal)
        standingsButton.setTitle("Standings", for: .normal)
        [matchesButton, standingsButton].forEach {
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 14)
        }

        indicator.backgroundColor = .white
        indicator.layer.cornerRadius = 2
        indicator.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    override func setupConstraints() {
        backButton.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(12)
        }

        logoContainer.snp.makeConstraints {
            $0.size.equalTo(56)
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(backButton.snp.bottom).offset(12)
        }

        leagueLogo.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(logoContainer.snp.trailing).offset(16)
            $0.top.equalTo(logoContainer.snp.top).offset(4)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
            $0.height.equalTo(28)
        }

        countryLabel.snp.makeConstraints {
            $0.leading.equalTo(logoContainer.snp.trailing).offset(16)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
            $0.height.equalTo(16)
        }

        tabsStack.snp.makeConstraints {
            $0.top.equalTo(logoContainer.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
            $0.bottom.equalToSuperview()
        }

        indicator.snp.makeConstraints {
            $0.bottom.equalTo(tabsStack.snp.bottom)
            $0.height.equalTo(4)
            $0.centerX.equalTo(matchesButton.snp.centerX)
            $0.leading.trailing.equalTo(matchesButton).inset(8)
        }
    }

    override func setupGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backTapped))
        backButton.addGestureRecognizer(tap)

        matchesButton.addTarget(self, action: #selector(matchesTapped), for: .touchUpInside)
        standingsButton.addTarget(self, action: #selector(standingsTapped), for: .touchUpInside)
    }

    func configure(logo: UIImage, name: String, country: String) {
        leagueLogo.image = logo
        nameLabel.text = name
        countryLabel.text = country
    }

    func selectTab(_ tab: Tab, animated: Bool) {
        let target = (tab == .matches) ? matchesButton : standingsButton

        indicator.snp.remakeConstraints {
            $0.bottom.equalTo(tabsStack.snp.bottom)
            $0.height.equalTo(4)
            $0.centerX.equalTo(target.snp.centerX)
            $0.leading.trailing.equalTo(target).inset(8)
        }

        guard animated else {
            layoutIfNeeded()
            return
        }

        UIView.animate(withDuration: 0.15) {
            self.layoutIfNeeded()
        }
    }

    @objc private func backTapped() {
        onBack?()
    }

    @objc private func matchesTapped() {
        selectTab(.matches, animated: true)
        onTabChange?(.matches)
    }

    @objc private func standingsTapped() {
        selectTab(.standings, animated: true)
        onTabChange?(.standings)
    }
}
