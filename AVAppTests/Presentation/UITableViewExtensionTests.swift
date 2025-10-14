//
//  UITableViewExtensionTests.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//


import Testing
import Foundation
import UIKit
@testable import AVApp

@MainActor
struct UITableViewExtensionTests {
    class TestCell: UITableViewCell {}

    @Test("registerCell should register cell with correct identifier")
    func registerCellShouldRegisterCellWithCorrectIdentifier() {
        // Given
        let tableView = UITableView()

        // When
        tableView.registerCell(ofType: TestCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell")

        // Then
        #expect(cell != nil)
    }

    @Test("dequeueReusableCell should return correct cell type")
    func dequeueReusableCellShouldReturnCorrectCellType() {
        // Given
        let tableView = UITableView()
        tableView.registerCell(ofType: TestCell.self)

        // When
        let cell = tableView.dequeueReusableCell(ofType: TestCell.self)

        // Then
        #expect(cell != nil)
    }
}
