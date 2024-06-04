//
//  JSONdecoder.swift
//  MangaApp
//
//  Created by Fran Malo on 4/6/24.
//

import Foundation

func getJSONFromURL<T>(url: URL, type: T.Type) async throws -> T where T: Codable {
    let (data, response) = try await URLSession.shared.getData(url: url)
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(.dateFormatCustom)
    
    if response.statusCode == 200 {
        do {
            return try decoder.decode(type, from: data)
        } catch {
            throw NetworkError.json(error)
        }
        
    } else {
        throw NetworkError.status(response.statusCode)
    }
    
}
