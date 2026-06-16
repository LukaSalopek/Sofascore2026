//
//  PlayerCell.swift
//  Zadatak3
//

import UIKit
import SnapKit

class PlayerCell: UITableViewCell {

    static let reuseIdentifier = "PlayerCell"

    private let playerView = PlayerView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .white
        contentView.backgroundColor = .white

        contentView.addSubview(playerView)
        playerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        playerView.resetImage()
    }

    func configure(name: String, country: String?, image: UIImage?) {
        playerView.configure(name: name, country: country)
        playerView.updateImage(image: image)
    }
}
