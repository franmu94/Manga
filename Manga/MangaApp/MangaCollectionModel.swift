//
//  MangaCollectionModel.swift
//  MangaApp
//
//  Created by Fran Malo on 1/7/24.
//

import Foundation


struct MangaCollectionModel: Codable {
    let manga: Int
    let completeCollection: Bool
    let volumesOwned: [Int]
    let readingVolume: Int
}

struct UserCollectionManga: Codable, Hashable, Identifiable {
    let id: UUID
    let manga: MangaDTO
    let completeCollection: Bool
    let volumesOwned: Int
    let readingVolume: [Int]
}
