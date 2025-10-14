//
//  AVTableViewCell.swift
//  AVApp
//
//  Created by Alexandre Faltot on 12/10/2025.
//

import UIKit

class AVUITableViewCell<ContentView: UIView>: UITableViewCell {
    private(set) lazy var content = ContentView()
    var insets: UIEdgeInsets = .zero

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    func setupView() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        addConstrainedSubview(content, with: insets)
    }
}
