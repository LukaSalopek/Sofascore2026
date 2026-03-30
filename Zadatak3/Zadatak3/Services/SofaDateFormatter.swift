//
//  SofaDateFormatter.swift
//  Zadatak3
//
//  Created by akademija on 18.03.2026..
//

import Foundation

final class SofaDateFormatter {

    static let shared = SofaDateFormatter()
    
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
