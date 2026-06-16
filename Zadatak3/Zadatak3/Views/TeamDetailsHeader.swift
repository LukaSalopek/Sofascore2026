//
//  TeamDetailsHeader.swift
//  Zadatak3
//

import UIKit
import SnapKit
import SofaAcademic

class TeamDetailsHeader: BaseView {

    enum Tab: Int, CaseIterable {
        case details, squad

        var title: String {
            switch self {
            case .details: return "Details"
            case .squad: return "Squad"
            }
        }
    }

    private let backButton = UIImageView()
    private let logoContainer = UIView()
    private let teamLogo = UIImageView()
    private let nameLabel = UILabel()
    private let countryStack = UIStackView()
    private let countryLabel = UILabel()

    private let tabsStack = UIStackView()
    private let indicator = UIView()
    private var tabButtons: [UIButton] = []

    var onBack: (() -> Void)?
    var onTabChange: ((Tab) -> Void)?

    override func addViews() {
        addSubview(backButton)
        addSubview(logoContainer)
        logoContainer.addSubview(teamLogo)
        addSubview(nameLabel)
        addSubview(countryStack)
        countryStack.addArrangedSubview(countryLabel)
        addSubview(tabsStack)

        Tab.allCases.forEach { tab in
            let button = UIButton(type: .system)
            button.setTitle(tab.title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
            button.tag = tab.rawValue
            button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            tabButtons.append(button)
            tabsStack.addArrangedSubview(button)
        }

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

        teamLogo.contentMode = .scaleAspectFit

        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        nameLabel.textColor = .white

        countryStack.axis = .horizontal
        countryStack.alignment = .center
        countryStack.spacing = 6

        countryLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        countryLabel.textColor = .white

        tabsStack.axis = .horizontal
        tabsStack.distribution = .fillEqually

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
            $0.size.equalTo(48)
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(backButton.snp.bottom).offset(12)
        }

        teamLogo.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(6)
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(logoContainer.snp.trailing).offset(12)
            $0.top.equalTo(logoContainer.snp.top).offset(2)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
            $0.height.equalTo(16)
        }

        countryStack.snp.makeConstraints {
            $0.leading.equalTo(logoContainer.snp.trailing).offset(12)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
            $0.height.equalTo(16)
        }

        countryLabel.snp.makeConstraints {
            $0.height.equalTo(16)
        }

        tabsStack.snp.makeConstraints {
            $0.top.equalTo(logoContainer.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview()
        }

        guard let first = tabButtons.first else { return }
        indicator.snp.makeConstraints {
            $0.bottom.equalTo(tabsStack.snp.bottom)
            $0.height.equalTo(4)
            $0.leading.trailing.equalTo(first).inset(8)
        }
    }

    override func setupGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backTapped))
        backButton.addGestureRecognizer(tap)
    }

    func configure(logo: UIImage, name: String, country: String) {
        teamLogo.image = logo
        nameLabel.text = name
        setCountry(country)
    }

    func setCountry(_ country: String) {
        countryLabel.text = country
    }

    func selectTab(_ tab: Tab, animated: Bool) {
        let target = tabButtons[tab.rawValue]

        indicator.snp.remakeConstraints {
            $0.bottom.equalTo(tabsStack.snp.bottom)
            $0.height.equalTo(4)
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

    @objc private func tabTapped(_ sender: UIButton) {
        guard let tab = Tab(rawValue: sender.tag) else { return }
        selectTab(tab, animated: true)
        onTabChange?(tab)
    }

    @objc private func backTapped() {
        onBack?()
    }
}
