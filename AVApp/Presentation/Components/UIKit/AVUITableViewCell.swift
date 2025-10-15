//
//  AVTableViewCell.swift
//  AVApp
//
//  Created by Alexandre Faltot on 12/10/2025.
//

import UIKit

class AVUITableViewCell<ContentView: UIView>: UITableViewCell {
    // MARK: - Private properties
    private(set) lazy var content = ContentView()

    // MARK: - Public properties
    var insets: NSDirectionalEdgeInsets = .zero

    // MARK: - Lifecycle

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    // MARK: - Public methods

    func setupView() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        addConstrainedSubview(content, with: insets)
    }
}
