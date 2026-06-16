//
//  RoundView.swift
//  Zadatak3
//

import UIKit
import SnapKit
import SofaAcademic

class RoundView: BaseView {

    private let titleLabel = UILabel()

    override func addViews() {
        addSubview(titleLabel)
    }

    override func styleViews() {
        backgroundColor = .sofaEventDetailsBackground

        titleLabel.font = .systemFont(ofSize: 12, weight: .bold)
        titleLabel.textColor = .sofaTextBlack
    }

    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(8)
            $0.height.equalTo(16)
        }
    }

    func configure(round: Int) {
        titleLabel.text = "Round \(round)"
    }
}
