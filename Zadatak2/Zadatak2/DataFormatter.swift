//
//  DataFormatter.swift
//  Zadatak2
//
//  Created by akademija on 17.03.2026..
//

import Foundation

final class DataFormatter {

    static let shared = DataFormatter()
    
    private let formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        return df
    }()
    
    private init() {} 
    
    func formatter(interval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: interval)
        return formatter.string(from: date)
    }
    
    func dateFormat(interval: TimeInterval) -> Date {
        return Date(timeIntervalSince1970: interval)
    }
}
