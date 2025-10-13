//
//  AVMovieUITableViewCell.swift
//  AVApp
//
//  Created by Alexandre Faltot on 12/10/2025.
//

import UIKit

class AVUIMovieTableViewCell: AVUITableViewCell<AVUIMovieCell> {
    override func setupView() {
        self.insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        super.setupView()
    }

    func setup(with movie: AVMovie) {
        content.setup(with: movie)
    }
}
