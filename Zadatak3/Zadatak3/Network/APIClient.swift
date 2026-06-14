//
//  APIClient.swift
//  Zadatak3
//
//  Created by akademija on 08.05.2026..
//

import Foundation
import UIKit
import ImageIO

final class APIClient {

    static let shared = APIClient()

    private init() {}

    private let baseURL = "https://sofascore-ios-academy-be-c63faa1a2212.herokuapp.com"

    func fetchEvents(sport: String) async throws -> [Event] {
        guard var urlComponents = URLComponents(string: "\(baseURL)/events") else {
            throw APIError.invalidURL
        }
        
        urlComponents.queryItems = [URLQueryItem(name: "sport", value: sport)]
        guard let url = urlComponents.url else { throw APIError.invalidURL }
        
        var request = URLRequest(url: url)
        
        if let token = AuthManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        print("➡️ events status: \(httpResponse.statusCode)")
        
        if httpResponse.statusCode == 401 {
            throw APIError.unauthorized
        }
        guard httpResponse.statusCode == 200 else {
            let body = String(data: data, encoding: .utf8) ?? ""
            throw APIError.serverError(statusCode: httpResponse.statusCode, body: body)
        }
        
        do {
            return try JSONDecoder().decode([Event].self, from: data)
        } catch {
            print("➡️ Decoding fail. Raw body:")
            print(String(data: data, encoding: .utf8) ?? "<no body>")
            throw APIError.decodingError(error)
        }
    }

    func fetchEventsOld(
            sport: String,
            completion: @escaping (Result<[Event], Error>) -> Void
        ) {

            guard let url = URL(
                string: "\(baseURL)/events?sport=\(sport)"
            ) else {
                completion(.failure(APIError.invalidURL))
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in

                if let error {
                    completion(.failure(error))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    completion(.failure(APIError.invalidResponse))
                    return
                }

                guard let data else {
                    completion(.failure(APIError.invalidResponse))
                    return
                }

                do {
                    let decoder = JSONDecoder()

                    let events = try decoder.decode([Event].self, from: data)

                    completion(.success(events))

                } catch {
                    completion(.failure(APIError.invalidResponse))
                }

            }.resume()
        }

    func fetchImage(from urlString: String?) async -> UIImage? {

        guard let urlString,
              let url = URL(string: urlString) else {
            return nil
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return APIClient.downsampledImage(from: data, maxPixelSize: 256)
            ?? APIClient.safeImage(from: data)
        } catch {
            return nil
        }
    }

    private static func downsampledImage(from data: Data, maxPixelSize: Int) -> UIImage? {
        let sourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary

        guard let source = CGImageSourceCreateWithData(data as CFData, sourceOptions) else {
            return nil
        }

        let thumbnailOptions: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixelSize
        ]

        guard let cgImage = CGImageSourceCreateThumbnailAtIndex(source, 0, thumbnailOptions as CFDictionary) else {
            return nil
        }

        return UIImage(cgImage: cgImage)
    }

    private static func safeImage(from data: Data, maxPixelSize: CGFloat = 1024) -> UIImage? {
        guard let image = UIImage(data: data) else { return nil }

        let pixelWidth = image.size.width * image.scale
        let pixelHeight = image.size.height * image.scale

        if pixelWidth > maxPixelSize || pixelHeight > maxPixelSize {
            return nil
        }
        return image
    }

    func login(username: String, password: String) async throws -> LoginResponse {
        guard let url = URL(string: "\(baseURL)/login") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = LoginRequest(username: username, password: password)
        request.httpBody = try JSONEncoder().encode(body)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        guard httpResponse.statusCode == 200 else {
            let respBody = String(data: data, encoding: .utf8) ?? ""
            throw APIError.serverError(statusCode: httpResponse.statusCode, body: respBody)
        }

        do {
            return try JSONDecoder().decode(LoginResponse.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    func fetchLeagueMatches(leagueId: Int) async throws -> [Event] {
        guard let url = URL(string: "\(baseURL)/leagues/\(leagueId)/matches") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        if let token = AuthManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        if httpResponse.statusCode == 401 {
            throw APIError.unauthorized
        }
        guard httpResponse.statusCode == 200 else {
            let body = String(data: data, encoding: .utf8) ?? ""
            throw APIError.serverError(statusCode: httpResponse.statusCode, body: body)
        }
        do {
            return try JSONDecoder().decode([Event].self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }

    func fetchLeagueStandings(leagueId: Int) async throws -> [Standings] {
        guard let url = URL(string: "\(baseURL)/leagues/\(leagueId)/standings") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        if let token = AuthManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        if httpResponse.statusCode == 401 {
            throw APIError.unauthorized
        }
        guard httpResponse.statusCode == 200 else {
            let body = String(data: data, encoding: .utf8) ?? ""
            throw APIError.serverError(statusCode: httpResponse.statusCode, body: body)
        }
        do {
            return try JSONDecoder().decode([Standings].self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }

    func fetchTeamInfo(teamId: Int) async throws -> TeamInfo {
        try await get("/teams/\(teamId)")
    }

    func fetchTeamPlayers(teamId: Int) async throws -> [Player] {
        try await get("/teams/\(teamId)/players")
    }

    func fetchTeamTournaments(teamId: Int) async throws -> [League] {
        try await get("/teams/\(teamId)/tournaments")
    }

    private func get<T: Decodable>(_ path: String) async throws -> T {
        guard let url = URL(string: "\(baseURL)\(path)") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        if let token = AuthManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        if httpResponse.statusCode == 401 {
            throw APIError.unauthorized
        }
        guard httpResponse.statusCode == 200 else {
            let body = String(data: data, encoding: .utf8) ?? ""
            throw APIError.serverError(statusCode: httpResponse.statusCode, body: body)
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }

    func fetchIncidents(eventId : Int) async throws -> [Incident] {
        guard var url = URL(string: "\(baseURL)/events/\(eventId)/incidents") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        if let token = AuthManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        if httpResponse.statusCode == 401 {
            throw APIError.unauthorized
        }
        
        guard httpResponse.statusCode == 200 else {
            let body = String(data: data, encoding: .utf8) ?? ""
            throw APIError.serverError(statusCode: httpResponse.statusCode, body: body)
        }
        do {
            return try JSONDecoder().decode([Incident].self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
}
