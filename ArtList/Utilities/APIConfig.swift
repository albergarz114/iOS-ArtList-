//
//  APIConfig.swift
//  ArtList
//
//  Created by Alberto Garza on 05.12.25.
//

import Foundation

enum APIKeys {
    static var api_key: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            print("API Key not found in the Info.plist")
            return "Default API Key"
        }
        return key
    }
}
