//
//  MangaModel.swift
//  MangaApp
//
//  Created by Fran Malo on 30/5/24.
//

import Foundation

// MARK: - Pelicula
struct MangaResultDTO: Codable {
    let metadata: Metadata
    let items: [MangaDTO]
}

// MARK: - Item
struct MangaDTO: Codable, Identifiable, Hashable {
    let score: Double
    let title: String
    let background: String?
    let endDate: Date?
    let status: MangaStatus
    let authors: [Author]
    let sypnosis: String?
    let volumes: Int?
    let genres: [Genres]
    let themes: [Themes]
    let id: Int
    let chapters: Int?
    let titleJapanese: String?
    let titleEnglish: String?
    let mainPicture: String
    let startDate: Date?
    let url: String
    
    var mainPictureURL: URL? {
        let urlString = mainPicture.replacingOccurrences(of: "\"", with: "")
        return URL(string: urlString)
    }
}

struct Genres: Codable, Hashable{
    let genre: Genre
}

struct Themes: Codable, Hashable {
    let theme: Theme
}
// MARK: - Author
struct Author: Codable, Hashable {
    let lastName, firstName, id: String
    
    let role: Role
}


// MARK: - Metadata
struct Metadata: Codable {
    let page, per, total: Int
}


