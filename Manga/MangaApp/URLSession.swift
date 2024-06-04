//
//  URLSession.swift
//  MangaApp
//
//  Created by Fran Malo on 4/6/24.
//

import Foundation

extension URLSession {
    func getData(url: URL) async throws -> (data: Data, response: HTTPURLResponse) {
        let (data, response) = try await data(from: url)
        print(url)
        
        guard let responseHTTP = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTP
        }
        
        return (data, responseHTTP)
    }
}
