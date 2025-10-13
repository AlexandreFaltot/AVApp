//
//  AVUISetupable.swift
//  AVApp
//
//  Created by Alexandre Faltot on 12/10/2025.
//


protocol AVUISetupable {
    associatedtype Model

    func setup(with model: Model)
}
