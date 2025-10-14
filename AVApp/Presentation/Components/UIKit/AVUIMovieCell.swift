//
//  AVMovieCell.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//
//
//  AVMovieCell.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//

import UIKit

@IBDesignable
final class AVUIMovieCell: AVNibView {
    typealias Model = AVMovie

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var posterImageView: AVUIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func setupView() {
        super.setupView()
        ratingLabel.font = .mediumPoppinsFont(ofSize: 14.0)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        layer.shadowOpacity = 0.25
    }

    func setup(with model: AVMovie) {
        self.titleLabel.text = model.title
        self.releaseDateLabel.text = model.releaseDate?
            .formatted(date: .long, time: .omitted)
        self.genresLabel.text = model.genres.joined(separator: ", ")
        self.ratingLabel.text = String(localized: .movieRate(rate: model.rating.roundedTo1Decimal, numberOfRates: Int32(model.numberOfRatings)))
        self.synopsisLabel.text = model.synopsis
        if let posterUrl = model.posterUrl(.medium) {
            self.posterImageView.setupImage(with: posterUrl)
        }
    }
}

#if DEBUG
import SwiftUI

#Preview {
    PreviewContainer {
        let view = AVUIMovieCell()
        view.setup(with: .mock)
        view.posterImageView.image = .checkmark

        return UIViewPreview(view: view)
            .frame(width: 375, height: 200)
    }
}
#endif
