//
//  MangaCollectionModel.swift
//  MangaApp
//
//  Created by Fran Malo on 1/7/24.
//

import Foundation


struct MangaCollectionModel: Codable { //Esto es lo que damos a la API, lo emplearemos con el POST
    let manga: Int
    let completeCollection: Bool
    let volumesOwned: [Int]
    let readingVolume: Int
}

struct UserCollectionManga: Codable, Hashable, Identifiable { //Esto es lo que nos devuelve la API, lo emplearemos con el GET
    let id: UUID
    let manga: MangaDTO
    let completeCollection: Bool
    let volumesOwned: Int
    let readingVolume: [Int]
}
