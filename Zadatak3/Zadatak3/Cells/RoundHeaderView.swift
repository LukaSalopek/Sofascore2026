//
//  RoundHeaderView.swift
//  Zadatak3
//

import UIKit
import SnapKit

class RoundHeaderView: UITableViewHeaderFooterView {

    static let reuseIdentifier = "RoundHeader"

    private let titleLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        let background = UIView()
        background.backgroundColor = .sofaEventDetailsBackground
        backgroundView = background

        titleLabel.font = .systemFont(ofSize: 12, weight: .bold)
        titleLabel.textColor = .sofaTextBlack

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(8)
            $0.height.equalTo(16)
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(round: Int) {
        titleLabel.text = "Round \(round)"
    }
}
