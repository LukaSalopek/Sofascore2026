//
//  TeamDetailsView.swift
//  Zadatak3
//

import UIKit
import SnapKit
import SofaAcademic

class TeamDetailsView: BaseView {

    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()

    override func addViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentStack)
    }

    override func styleViews() {
        backgroundColor = .white

        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        scrollView.contentInsetAdjustmentBehavior = .never

        contentStack.axis = .vertical
    }

    override func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }

        contentStack.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
    }

    func configure(info: TeamInfo?, players: [Player], tournaments: [League], images: [String: UIImage]) {
        contentStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let total = players.count
        let foreign = players.filter { $0.isForeign == true }.count

        contentStack.addArrangedSubview(makeTitle("Team Info"))
        contentStack.addArrangedSubview(makeCoachRow(info?.manager, images: images))
        contentStack.addArrangedSubview(makeSeparator())
        contentStack.addArrangedSubview(makeStatsRow(total: total, foreign: foreign))

        if !tournaments.isEmpty {
            contentStack.addArrangedSubview(makeSeparator())
            contentStack.addArrangedSubview(makeTitle("Tournaments"))
            makeTournamentRows(tournaments, images: images).forEach { contentStack.addArrangedSubview($0) }
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

    private func makeCoachRow(_ manager: TeamManager?, images: [String: UIImage]) -> UIView {
        let container = UIView()
        container.snp.makeConstraints { $0.height.equalTo(56) }

        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        image.backgroundColor = .sofaIncidentBackgrund
        image.image = self.image(for: manager?.imageUrl, in: images) ?? PlayerView.avatarPlaceholder

        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        nameLabel.textColor = .sofaTextBlack
        nameLabel.text = "Coach: \(manager?.name ?? "-")"

        let country = UILabel()
        country.font = .systemFont(ofSize: 12)
        country.textColor = .sofaGray
        country.text = manager?.country?.name ?? ""

        container.addSubview(image)
        container.addSubview(nameLabel)
        container.addSubview(country)

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
            $0.leading.equalTo(image.snp.trailing).offset(16)
            $0.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(16)
        }
        return container
    }

    private func makeStatsRow(total: Int, foreign: Int) -> UIView {
        let container = UIView()
        container.snp.makeConstraints { $0.height.equalTo(116) }

        let icon = UIImageView(image: UIImage(named: "ic_team"))
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

    private func makeTournamentRows(_ tournaments: [League], images: [String: UIImage]) -> [UIView] {
        var rows: [UIView] = []
        var index = 0
        while index < tournaments.count {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.distribution = .fillEqually

            for offset in 0 ..< 3 {
                if index + offset < tournaments.count {
                    rowStack.addArrangedSubview(makeTournamentCell(tournaments[index + offset], images: images))
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

    private func makeTournamentCell(_ tournament: League, images: [String: UIImage]) -> UIView {
        let cell = UIView()

        let logo = UIImageView()
        logo.contentMode = .scaleAspectFit
        logo.image = image(for: tournament.logoUrl, in: images)

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
        valueLabel.font = .systemFont(ofSize: 14)
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
        line.backgroundColor = .sofaSeparatorLight
        container.addSubview(line)
        line.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        return container
    }

    private func image(for urlString: String?, in images: [String: UIImage]) -> UIImage? {
        guard let urlString else { return nil }
        return images[urlString]
    }
}
