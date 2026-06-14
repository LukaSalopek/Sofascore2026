//
//  TeamDetailsView.swift
//  Zadatak3
//

import UIKit
import SnapKit

typealias ImageLoader = (String?, @escaping (UIImage?) -> Void) -> Void

class TeamDetailsView: UIView {

    var imageLoader: ImageLoader?

    static let avatarPlaceholder = UIImage(systemName: "person.crop.circle.fill")?
        .withTintColor(.sofaLightGray, renderingMode: .alwaysOriginal)

    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setup() {
        addSubview(scrollView)
        scrollView.addSubview(contentStack)

        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }

        contentStack.axis = .vertical
        contentStack.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
    }

    func configure(info: TeamInfo?, players: [Player], tournaments: [League]) {
        contentStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let total = players.count
        let foreign = players.filter { $0.isForeign == true }.count

        contentStack.addArrangedSubview(makeTitle("Team Info"))
        contentStack.addArrangedSubview(makeCoachRow(info?.manager))
        contentStack.addArrangedSubview(makeSeparator())
        contentStack.addArrangedSubview(makeStatsRow(total: total, foreign: foreign))

        if !tournaments.isEmpty {
            contentStack.addArrangedSubview(makeSeparator())
            contentStack.addArrangedSubview(makeTitle("Tournaments"))
            makeTournamentRows(tournaments).forEach { contentStack.addArrangedSubview($0) }
        }

        contentStack.addArrangedSubview(makeSeparator())
        contentStack.addArrangedSubview(makeTitle("Venue"))
        contentStack.addArrangedSubview(makeVenueRow(info?.venue))
    }

    private func makeTitle(_ text: String) -> UIView {
        let container = UIView()
        container.snp.makeConstraints { $0.height.equalTo(48) }

        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .sofaTextBlack
        label.textAlignment = .center

        container.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(20)
        }
        return container
    }

    private func makeCoachRow(_ manager: TeamManager?) -> UIView {
        let container = UIView()
        container.snp.makeConstraints { $0.height.equalTo(56) }

        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        image.backgroundColor = .sofaIncidentBackgrund
        loadImage(manager?.imageUrl, into: image, placeholder: TeamDetailsView.avatarPlaceholder)

        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        nameLabel.textColor = .sofaTextBlack
        nameLabel.text = "Coach: \(manager?.name ?? "-")"

        let flag = UILabel()
        flag.font = .systemFont(ofSize: 14)
        flag.text = CountryFlag.emoji(for: manager?.country?.name)

        let country = UILabel()
        country.font = .systemFont(ofSize: 12)
        country.textColor = .sofaGray
        country.text = manager?.country?.name ?? ""

        let countryRow = UIStackView(arrangedSubviews: [flag, country])
        countryRow.axis = .horizontal
        countryRow.alignment = .center
        countryRow.spacing = 4

        container.addSubview(image)
        container.addSubview(nameLabel)
        container.addSubview(countryRow)

        image.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(8)
            $0.size.equalTo(40)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(image.snp.trailing).offset(16)
            $0.top.equalToSuperview().inset(10)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
            $0.height.equalTo(16)
        }
        country.snp.makeConstraints {
            $0.height.equalTo(16)
        }
        countryRow.snp.makeConstraints {
            $0.leading.equalTo(image.snp.trailing).offset(16)
            $0.bottom.equalToSuperview().inset(10)
        }
        return container
    }

    private func makeStatsRow(total: Int, foreign: Int) -> UIView {
        let container = UIView()
        container.snp.makeConstraints { $0.height.equalTo(116) }

        let icon = UIImageView(image: UIImage(systemName: "person.2.fill"))
        icon.tintColor = .sofaBlue
        icon.contentMode = .scaleAspectFit
        icon.snp.makeConstraints { $0.size.equalTo(40) }

        let ring = ProgressRingView()
        ring.snp.makeConstraints { $0.size.equalTo(40) }
        ring.setProgress(total > 0 ? CGFloat(foreign) / CGFloat(total) : 0)

        let row = UIStackView(arrangedSubviews: [
            makeStatColumn(top: icon, value: total, caption: "Total Players"),
            makeStatColumn(top: ring, value: foreign, caption: "Foreign Players")
        ])
        row.axis = .horizontal
        row.distribution = .fillEqually
        row.alignment = .top

        container.addSubview(row)
        row.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview()
        }
        return container
    }

    private func makeStatColumn(top: UIView, value: Int, caption: String) -> UIView {
        let valueLabel = UILabel()
        valueLabel.font = .systemFont(ofSize: 14, weight: .bold)
        valueLabel.textColor = .sofaBlue
        valueLabel.text = "\(value)"
        valueLabel.snp.makeConstraints { $0.height.equalTo(16) }

        let captionLabel = UILabel()
        captionLabel.font = .systemFont(ofSize: 12)
        captionLabel.textColor = .sofaGray
        captionLabel.text = caption
        captionLabel.snp.makeConstraints { $0.height.equalTo(16) }

        let column = UIStackView(arrangedSubviews: [top, valueLabel, captionLabel])
        column.axis = .vertical
        column.alignment = .center
        column.spacing = 8
        column.setCustomSpacing(4, after: valueLabel)
        return column
    }

    private func makeTournamentRows(_ tournaments: [League]) -> [UIView] {
        var rows: [UIView] = []
        var index = 0
        while index < tournaments.count {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.distribution = .fillEqually

            for offset in 0 ..< 3 {
                if index + offset < tournaments.count {
                    rowStack.addArrangedSubview(makeTournamentCell(tournaments[index + offset]))
                } else {
                    rowStack.addArrangedSubview(UIView())
                }
            }

            let container = UIView()
            container.snp.makeConstraints { $0.height.equalTo(96) }
            container.addSubview(rowStack)
            rowStack.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.top.bottom.equalToSuperview()
            }

            rows.append(container)
            index += 3
        }
        return rows
    }

    private func makeTournamentCell(_ tournament: League) -> UIView {
        let cell = UIView()

        let logo = UIImageView()
        logo.contentMode = .scaleAspectFit
        loadImage(tournament.logoUrl, into: logo)

        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 12)
        nameLabel.textColor = .sofaGray
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
        nameLabel.text = tournament.name

        cell.addSubview(logo)
        cell.addSubview(nameLabel)

        logo.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(40)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        return cell
    }

    private func makeVenueRow(_ venue: TeamVenue?) -> UIView {
        let container = UIView()
        container.snp.makeConstraints { $0.height.equalTo(32) }

        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .sofaTextBlack
        titleLabel.text = "Stadium"

        let valueLabel = UILabel()
        valueLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        valueLabel.textColor = .sofaTextBlack
        valueLabel.textAlignment = .right
        valueLabel.text = venue?.name ?? "-"

        container.addSubview(titleLabel)
        container.addSubview(valueLabel)

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(16)
        }
        valueLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(8)
            $0.height.equalTo(16)
        }
        return container
    }

    private func makeSeparator() -> UIView {
        let container = UIView()
        container.backgroundColor = .white
        container.snp.makeConstraints { $0.height.equalTo(8) }

        let line = UIView()
        line.backgroundColor = .sofaSeparator
        container.addSubview(line)
        line.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        return container
    }

    private func loadImage(_ urlString: String?, into imageView: UIImageView, placeholder: UIImage? = nil) {
        imageView.image = placeholder
        imageLoader?(urlString) { image in
            imageView.image = image ?? placeholder
        }
    }
}
