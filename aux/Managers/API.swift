//
//  API.swift
//  aux
//
//  Created by Robert Pruzan on 5/19/24.
//

import Foundation

class API {
    let baseUrl = "http://localhost:3000"
    let cookie: String? = nil
    
    init() {
//        self.cookie = cookie
    }

    func get<T: Codable>(for path: String, codable: T.Type) async throws -> T {
        guard let url = URL(string: baseUrl + path) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        if let cookie = cookie {
            request.addValue(cookie, forHTTPHeaderField: "Cookie")
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(codable.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
    
    
    func post<T: Encodable, U: Codable>(for path: String, body: T, responseType: U.Type) async throws -> U {
           guard let url = URL(string: baseUrl + path) else {
               throw APIError.invalidURL
           }
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           
           if let cookie = cookie {
               request.addValue(cookie, forHTTPHeaderField: "Cookie")
           }

           do {
               let encoder = JSONEncoder()
               encoder.keyEncodingStrategy = .convertToSnakeCase
               request.httpBody = try encoder.encode(body)
           } catch {
               throw APIError.encodingError
           }

           let (data, response) = try await URLSession.shared.data(for: request)
           guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
               throw APIError.invalidResponse
           }

           do {
               let decoder = JSONDecoder()
               decoder.keyDecodingStrategy = .convertFromSnakeCase
               return try decoder.decode(U.self, from: data)
           } catch {
               throw APIError.decodingError
           }
       }
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case encodingError
}
