//
//  DataService.swift
//  ArtList
//
//  Created by Alberto Garza on 05.12.25.
//

import Foundation

struct DataService {
    
    func artSearch(query: String? = nil, origin: String? = nil, material: String? = nil, earliest_start_date: Int? = nil) async -> [Artworks] {
        
        var urlComponents = URLComponents(string: "https://api.artsearch.io/artworks")!
        
        var queryItems = [URLQueryItem(name: "api-key", value: APIKeys.api_key)]
        
        if let query = query {
            queryItems.append(URLQueryItem(name: "query", value: query))
        }
        
        if let origin = origin {
            queryItems.append(URLQueryItem(name: "origin", value: origin))
        }
        
        if let material = material {
            queryItems.append(URLQueryItem(name: "material", value: material))
        }
        
        if let earliest_start_date = earliest_start_date {
            queryItems.append(URLQueryItem(name: "earliest_start_date", value: "\(earliest_start_date)"))
        }
        
        
        urlComponents.queryItems = queryItems
        
        if let url = urlComponents.url {
            var request = URLRequest(url: url)
            //request.addValue(APIKeys.api_key, forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                
                // DEBUG
                print("RAW JSON: \(String(data: data, encoding: .utf8) ?? "No data"))")
                _ = JSONDecoder()
                
                do {
                    _ = String(data: data, encoding: .utf8)
                    let apiObject = try JSONDecoder().decode(APIObject.self, from: data)
                    return apiObject.artworks
                } catch {
                    print("Error: \(error)")
                    return []
                }
            } catch {
                print("Network Error: \(error)")
                return []
            }
            
        }
        return []
    }
}
