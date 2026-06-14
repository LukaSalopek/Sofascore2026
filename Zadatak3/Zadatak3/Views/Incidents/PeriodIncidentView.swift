//
//  PeriodIncidentView.swift
//  Zadatak3
//
//  Created by akademija on 08.06.2026..
//

import SnapKit
import SofaAcademic
import UIKit

class PeriodIncidentView: BaseView {

    private let container = UIView()
    private let titleLabel = UILabel()

    override func addViews() {
        addSubview(container)
        container.addSubview(titleLabel)
    }

    override func styleViews() {
        container.backgroundColor = .sofaIncidentBackgrund
        container.layer.cornerRadius = 8
        container.clipsToBounds = true

        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.textColor = .sofaTextBlack
        titleLabel.textAlignment = .center
        
    }

    override func setupConstraints() {
        container.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(8)
        }

        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.bottom.equalTo(container).inset(4)
            $0.leading.greaterThanOrEqualToSuperview().inset(100)
            $0.trailing.lessThanOrEqualToSuperview().inset(100)
            $0.height.equalTo(16)
        }
    }


    func setTitle(_ title: String) { titleLabel.text = title }
}
