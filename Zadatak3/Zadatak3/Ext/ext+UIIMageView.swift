//
//  ext+UIIMageView.swift
//  Zadatak3
//
//  Created by akademija on 09.05.2026..
//

import UIKit

extension UIImageView {

    func setImage(
        from urlString: String?
    ) {

        guard let urlString,
              let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in

            guard let data,
                  let image = UIImage(data: data) else {
                return
            }

            DispatchQueue.main.async {
                self.image = image
            }

        }.resume()
    }
}
