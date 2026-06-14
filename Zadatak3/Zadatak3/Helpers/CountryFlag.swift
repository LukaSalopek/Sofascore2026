//
//  CountryFlag.swift
//  Zadatak3
//

import Foundation

enum CountryFlag {

    static let placeholder = "🏳️"

    static func emoji(for countryName: String?) -> String {
        guard let countryName, !countryName.isEmpty else { return "" }
        guard let code = isoCodes[countryName.lowercased()] else { return placeholder }
        return flag(from: code)
    }

    private static func flag(from code: String) -> String {
        let base: UInt32 = 127397
        var result = ""
        for scalar in code.uppercased().unicodeScalars {
            if let regional = UnicodeScalar(base + scalar.value) {
                result.unicodeScalars.append(regional)
            }
        }
        return result
    }

    private static let isoCodes: [String: String] = [
        "spain": "ES",
        "croatia": "HR",
        "germany": "DE",
        "usa": "US",
        "united states": "US",
        "england": "GB",
        "scotland": "GB",
        "wales": "GB",
        "northern ireland": "GB",
        "united kingdom": "GB",
        "france": "FR",
        "italy": "IT",
        "portugal": "PT",
        "netherlands": "NL",
        "belgium": "BE",
        "argentina": "AR",
        "brazil": "BR",
        "uruguay": "UY",
        "mexico": "MX",
        "canada": "CA",
        "poland": "PL",
        "switzerland": "CH",
        "austria": "AT",
        "denmark": "DK",
        "sweden": "SE",
        "norway": "NO",
        "finland": "FI",
        "iceland": "IS",
        "ireland": "IE",
        "serbia": "RS",
        "slovenia": "SI",
        "slovakia": "SK",
        "czech republic": "CZ",
        "czechia": "CZ",
        "hungary": "HU",
        "greece": "GR",
        "turkey": "TR",
        "russia": "RU",
        "ukraine": "UA",
        "georgia": "GE",
        "estonia": "EE",
        "latvia": "LV",
        "lithuania": "LT",
        "bulgaria": "BG",
        "romania": "RO",
        "bosnia and herzegovina": "BA",
        "north macedonia": "MK",
        "montenegro": "ME",
        "albania": "AL",
        "kosovo": "XK",
        "japan": "JP",
        "south korea": "KR",
        "north korea": "KP",
        "korea": "KR",
        "china": "CN",
        "australia": "AU",
        "new zealand": "NZ",
        "israel": "IL",
        "iran": "IR",
        "india": "IN",
        "morocco": "MA",
        "egypt": "EG",
        "tunisia": "TN",
        "algeria": "DZ",
        "nigeria": "NG",
        "senegal": "SN",
        "ghana": "GH",
        "cameroon": "CM",
        "ivory coast": "CI",
        "mali": "ML",
        "angola": "AO",
        "colombia": "CO",
        "chile": "CL",
        "peru": "PE",
        "ecuador": "EC",
        "venezuela": "VE",
        "paraguay": "PY",
        "bolivia": "BO",
        "dominican republic": "DO",
        "puerto rico": "PR",
        "jamaica": "JM",
        "cuba": "CU"
    ]
}
