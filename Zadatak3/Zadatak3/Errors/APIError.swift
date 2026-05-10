//
//  APIError.swift
//  Zadatak3
//
//  Created by akademija on 08.05.2026..
//

import Foundation

enum APIError : Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError
}
