//
//  MangaUserCollectionInteractor.swift
//  MangaApp
//
//  Created by Fran Malo on 2/7/24.
//

import Foundation


protocol MangaUserCollectionInteractorProtocol {
    func postMangaCollection(manga: MangaCollectionModel) async throws
    func getUserCollection() async throws -> [UserCollectionManga]
    func removeFromCollection(mangaID: Int) async throws
}

struct MangaUserCollectionInteractor: MangaUserCollectionInteractorProtocol {
    
    static let shared =  MangaUserCollectionInteractor()
    
    let appConfig = AppConfig.shared
    let keychainManager = KeychainManager.shared
    
    
    func postMangaCollection(manga: MangaCollectionModel) async throws {
        let (_, response) = try await URLSession.shared.data(for: .postCollection(model: manga, apiPassword: appConfig.APIKey, url: .userCollectionURL, userToken: appConfig.userToken))
        
        if let responseHTTP = response as? HTTPURLResponse {
            if responseHTTP.statusCode != 201 {
                throw NetworkError.errorAddingManga
            }
        }
    }
    
    func getUserCollection() async throws -> [UserCollectionManga] {
        let (data, response) = try await URLSession.shared.data(for: .getUserCollection(url: .userCollectionURL, userToken: appConfig.userToken, apiPassword: appConfig.APIKey))
        
        guard let responseHTTP = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTP
        }
        
        switch responseHTTP.statusCode {
        case 200:
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.dateFormatCustom)
            return try decoder.decode([UserCollectionManga].self, from: data)
        default:
            throw NetworkError.status(responseHTTP.statusCode)
        }
    }
    
    func removeFromCollection(mangaID: Int) async throws {
        let (_, response) = try await URLSession.shared.data(for: .removeFromCollection(userToken: appConfig.userToken, url: .deleteMangaFromCollection(id: mangaID), apiPassword: appConfig.APIKey))
        
        guard let responseHTTP = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTP
        }
        
        if responseHTTP.statusCode != 200 {
            throw NetworkError.errorRemovingManga
        }
    }
    
}
