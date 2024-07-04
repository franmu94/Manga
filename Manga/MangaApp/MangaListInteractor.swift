//
//  MangaListInteractor.swift
//  MangaApp
//
//  Created by Fran Malo on 30/5/24.
//

import Foundation

protocol MangaListInteractorProtocol {
    func fetchMangasList(page: Int, per: Int) async throws -> MangaResultDTO
    
    func fetchMangasContains(name: String, page: Int) async throws -> MangaResultDTO
    
    func fetchMangasByGenre(genre: String, page: Int) async throws -> MangaResultDTO
    
    func fetchMangasByFilter(filterType: String, filterOption: String, page: Int) async throws -> MangaResultDTO

}

struct MangaListInteractor: MangaListInteractorProtocol {
     
    static let shared = MangaListInteractor()
    
    func fetchMangasList(page: Int, per: Int = 20) async throws -> MangaResultDTO {
        try await getJSONFromURL(url: .allMagasList(page: page, per: per), type: MangaResultDTO.self)
    }
    
    func fetchMangasContains(name: String, page: Int) async throws -> MangaResultDTO {
        try await getJSONFromURL(url: .searchMangaContainsURL(mangaName: name, page: page), type: MangaResultDTO.self)
    }
    
    func fetchMangasByGenre(genre: String, page: Int) async throws -> MangaResultDTO {
        try await getJSONFromURL(url: .filterMangasByGenreURL(genre: genre, page: page), type: MangaResultDTO.self)
    }
    
    func fetchMangasByFilter(filterType: String, filterOption: String, page: Int) async throws -> MangaResultDTO {
        try await getJSONFromURL(url: .filterMangasByType(filterType: filterType, filterOption: filterOption, page: page), type: MangaResultDTO.self)
    }
}



