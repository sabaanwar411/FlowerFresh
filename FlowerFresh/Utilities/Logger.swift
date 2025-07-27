//
//  Logger.swift
//  FlowerFresh
//
//  Created by Saba Anwar on 19/07/2025.
//

import Foundation
import os

class Logger {
    // Singleton instance
    static let shared = Logger()
    
    private let logger: os.Logger
    
    private init() {
        // Initialize os.Logger with subsystem and category
        self.logger = os.Logger(subsystem: "com.flowers.FlowerFresh", category: "App")
    }
    
    func info(_ message: String, category: String = "General") {
        let logMessage = "[\(category)] \(message)"
        logger.info("\(self.formattedDate()) \(logMessage, privacy: .public)")
    }
    
    func debug(_ message: String, category: String = "Debug") {
        let logMessage = "[\(category)] \(message)"
        logger.debug("\(self.formattedDate()) \(logMessage, privacy: .public)")
    }
    
    func error(_ message: String, category: String = "Error") {
        let logMessage = "[\(category)] \(message)"
        logger.error("\(self.formattedDate()) \(logMessage, privacy: .public)")
    }
    
    private func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "Asia/Karachi") // Set to PKT
        return formatter.string(from: Date())
    }
}
