//
//  Logger.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//

enum LoggerLevel: Int {
    case debug, info, warning, error
}

class Logger {
    var level: LoggerLevel = .error

    static private let shared = Logger()

    private init() {}

    static func debug(_ message: String) {
        shared.log(.debug, message: message)
    }

    static func info(_ message: String) {
        shared.log(.info, message: message)
    }

    static func warning(_ message: String) {
        shared.log(.warning, message: message)
    }

    static func error(_ message: String) {
        shared.log(.error, message: message)
    }

    private func log(_ level: LoggerLevel, message: String) {
        #if DEBUG
        print("[AVApp] [\(String(describing: level).uppercased())] \(message)")
        #endif
    }
}
