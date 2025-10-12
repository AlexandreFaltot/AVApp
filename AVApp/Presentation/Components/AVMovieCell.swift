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

class AVTableViewCell<ContentView: UIView>: UITableViewCell {
    private(set) lazy var content = ContentView()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    func setupView() {
        addConstrainedSubview(content)
    }
}

class AVMovieCell: XibView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!

    func setup(with movie: AVMovie) {
        self.titleLabel.text = movie.title
        self.releaseDateLabel.text = movie.releaseDate.formatted(date: .abbreviated, time: .omitted)
        self.genresLabel.text = movie.genres.joined(separator: ", ")
        self.ratingLabel.text = movie.rating.description
        self.synopsisLabel.text = movie.synopsis
        if let posterUrl = movie.posterUrl {
            self.posterImageView.setupImage(with: posterUrl)
        }
    }
}

@IBDesignable
class XibView: UIView {
    private(set) lazy var contentView: UIView? = {
        let nibName = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))

        return bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }

    private func loadFromNib() {
        guard let contentView else { return }
        addConstrainedSubview(contentView)
    }
}

extension UIView {
    func addConstrainedSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
