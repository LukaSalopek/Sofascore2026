//
//  PlayerCell.swift
//  Zadatak3
//

import UIKit
import SnapKit

class PlayerCell: UITableViewCell {

    static let reuseIdentifier = "PlayerCell"

    private let playerImage = UIImageView()
    private let nameLabel = UILabel()
    private let flagLabel = UILabel()
    private let countryLabel = UILabel()
    private let gapView = UIView()

    private var imageUrl: String?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .white
        contentView.backgroundColor = .white

        styleViews()
        layoutViews()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func styleViews() {
        playerImage.contentMode = .scaleAspectFill
        playerImage.clipsToBounds = true
        playerImage.layer.cornerRadius = 20
        playerImage.backgroundColor = .sofaIncidentBackgrund

        nameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        nameLabel.textColor = .sofaTextBlack

        flagLabel.font = .systemFont(ofSize: 14)

        countryLabel.font = .systemFont(ofSize: 12)
        countryLabel.textColor = .sofaGray

        gapView.backgroundColor = .white
    }

    private func layoutViews() {
        let countryRow = UIStackView(arrangedSubviews: [flagLabel, countryLabel])
        countryRow.axis = .horizontal
        countryRow.spacing = 4
        countryRow.alignment = .center

        contentView.addSubview(playerImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(countryRow)
        contentView.addSubview(gapView)

        gapView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(8)
        }

        let separatorLine = UIView()
        separatorLine.backgroundColor = .sofaSeparator
        gapView.addSubview(separatorLine)
        separatorLine.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
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

    override func prepareForReuse() {
        super.prepareForReuse()
        playerImage.image = TeamDetailsView.avatarPlaceholder
        imageUrl = nil
    }

    func configure(name: String, country: String?, imageUrl: String?, imageLoader: ImageLoader?) {
        nameLabel.text = name
        flagLabel.text = CountryFlag.emoji(for: country)
        countryLabel.text = country ?? ""

        self.imageUrl = imageUrl
        playerImage.image = TeamDetailsView.avatarPlaceholder

        imageLoader?(imageUrl) { [weak self] image in
            if self?.imageUrl == imageUrl {
                self?.playerImage.image = image ?? TeamDetailsView.avatarPlaceholder
            }
        }
    }
}
