//
//  PlayerView.swift
//  Zadatak3
//

import UIKit
import SnapKit
import SofaAcademic

class PlayerView: BaseView {

    static let avatarPlaceholder = UIImage(systemName: "person.crop.circle.fill")?
        .withTintColor(.sofaLightGray, renderingMode: .alwaysOriginal)

    private let playerImage = UIImageView()
    private let nameLabel = UILabel()
    private let countryLabel = UILabel()
    private let countryRow = UIStackView()
    private let gapView = UIView()
    private let separatorLine = UIView()

    override func addViews() {
        addSubview(playerImage)
        addSubview(nameLabel)
        addSubview(countryRow)
        countryRow.addArrangedSubview(countryLabel)
        addSubview(gapView)
        addSubview(separatorLine)
    }

    override func styleViews() {
        backgroundColor = .white

        playerImage.contentMode = .scaleAspectFill
        playerImage.clipsToBounds = true
        playerImage.layer.cornerRadius = 20
        playerImage.backgroundColor = .sofaIncidentBackgrund
        playerImage.image = PlayerView.avatarPlaceholder

        nameLabel.font = .systemFont(ofSize: 14)
        nameLabel.textColor = .sofaTextBlack

        countryLabel.font = .systemFont(ofSize: 12, weight: .bold)
        countryLabel.textColor = .sofaGray

        countryRow.axis = .horizontal
        countryRow.spacing = 4
        countryRow.alignment = .center

        gapView.backgroundColor = .white
        separatorLine.backgroundColor = .sofaSeparatorLight
    }

    override func setupConstraints() {
        separatorLine.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }

        gapView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(separatorLine.snp.top)
            $0.height.equalTo(7)
        }

        playerImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(8)
            $0.size.equalTo(40)
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(playerImage.snp.trailing).offset(16)
            $0.top.equalToSuperview().inset(10)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
            $0.height.equalTo(16)
        }

        countryLabel.snp.makeConstraints {
            $0.height.equalTo(16)
        }

        countryRow.snp.makeConstraints {
            $0.leading.equalTo(playerImage.snp.trailing).offset(16)
            $0.bottom.equalTo(gapView.snp.top).offset(-10)
        }
    }

    func configure(name: String, country: String?) {
        nameLabel.text = name
        countryLabel.text = country ?? ""
    }

    func updateImage(image: UIImage?) {
        playerImage.image = image ?? PlayerView.avatarPlaceholder
    }

    func resetImage() {
        playerImage.image = PlayerView.avatarPlaceholder
    }
}
