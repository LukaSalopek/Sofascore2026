//
//  APIError.swift
//  Zadatak3
//
//  Created by akademija on 08.05.2026..
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case serverError(statusCode: Int, body: String)
    case unauthorized

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid response from server."
        case .decodingError(let error):
            return "Decoding failed: \(error)"
        case .serverError(let statusCode, let body):
            return "Server error \(statusCode): \(body)"
        case .unauthorized:
            return "Unauthorized (401). Token missing or expired."
        }
    }
}
