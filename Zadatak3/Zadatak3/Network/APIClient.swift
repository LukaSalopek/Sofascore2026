//
//  APIClient.swift
//  Zadatak3
//
//  Created by akademija on 08.05.2026..
//

import Foundation
import UIKit

final class APIClient {
    
    static let shared = APIClient()
    
    private init(){}
    
    private let baseURL = "https://sofascore-ios-academy-be-c63faa1a2212.herokuapp.com"
    
    func fetchEvents(sport : String) async throws -> [Event] {
        
        guard let url = URL(string: "\(baseURL)/events?sport=\(sport)") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpsResponse = response as? HTTPURLResponse, 200...299 ~= httpsResponse.statusCode else {
            throw APIError.serverError
        }
        
        return try JSONDecoder().decode([Event].self, from: data)
        
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
                completion(.failure(APIError.serverError))
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
                completion(.failure(APIError.decodingError))
            }

        }.resume()
    }
    
    
    func fetchImage(
        from urlString: String?
    ) async -> UIImage? {

        guard let urlString,
              let url = URL(string: urlString) else {
            return nil
        }

        do {

            let (data, _) = try await URLSession.shared.data(from: url)

            return UIImage(data: data)

        } catch {
            return nil
        }
    }

    
}
