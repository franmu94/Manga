//
//  URL.swift
//  MangaApp
//
//  Created by Fran Malo on 21/5/24.
//
//Es

import Foundation

let mainURL = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com")!

extension URL {
    static let userRegisterURL = mainURL.appending(path: "users")
    static let userRenewURL = userRegisterURL.appending(path: "renew")
    static let userLoginURL = userRegisterURL.appending(path: "login")

    private static let listMangasURL = mainURL.appending(path: "list")
    private static let searchMangaContainsURL = mainURL.appending(path: "search/mangasContains")
    
    static let userCollectionURL = mainURL.appending(path: "collection/manga")


    static func allMagasList(page: Int, per: Int) -> URL {
        listMangasURL.appending(path: "mangas").appending(queryItems: [.page(page: page), .per(per: per)])
    }
    
    static func searchMangaContainsURL(mangaName: String, page: Int) -> URL {
        searchMangaContainsURL.appending(path: mangaName).appending(queryItems: [.page(page: page)])
    }
    
    static func filterMangasByGenreURL(genre: String, page: Int) -> URL {
        listMangasURL.appending(path: "mangaByGenre")
            .appending(path: genre)
            .appending(queryItems: [.page(page: page)])
    }
}


extension URLQueryItem {
    static func page(page: Int) -> URLQueryItem {
        URLQueryItem(name: "page", value: "\(page)")
    }
    
    static func per(per: Int) -> URLQueryItem {
        URLQueryItem(name: "per", value: "\(per)")
    }
}
