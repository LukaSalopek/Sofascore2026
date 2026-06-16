//
//  RoundHeaderView.swift
//  Zadatak3
//

import UIKit
import SnapKit

class RoundHeaderView: UITableViewHeaderFooterView {

    static let reuseIdentifier = "RoundHeader"

    private let roundView = RoundView()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        let background = UIView()
        background.backgroundColor = .sofaEventDetailsBackground
        backgroundView = background

        contentView.addSubview(roundView)
        roundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(round: Int) {
        roundView.configure(round: round)
    }
}
