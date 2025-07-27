//
//  StringExtension.swift
//  FlowerFresh
//
//  Created by Saba Anwar on 22/07/2025.
//
import Foundation

extension String {
    func toDateFormat(from inputFormat: String, to outputFormat: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = inputFormatter.date(from: self) {
            return outputFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
extension String {
    var trimmingSpacesAndNewlines: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var wordsCount: Int {
        let componenets = components(separatedBy: CharacterSet.whitespacesAndNewlines)
        return componenets.filter({!$0.isEmpty}).count
    }
}

