//
//  UserCollecionVM.swift
//  MangaApp
//
//  Created by Fran Malo on 11/7/24.
//

import SwiftUI

final class UserCollectionVM {
    var showAlert = false
    var userCollection : [UserCollectionManga] = []
    let interactor: MangaUserCollectionInteractorProtocol
    
    init(interactor: MangaUserCollectionInteractorProtocol = MangaUserCollectionInteractor.shared) {
        self.interactor = interactor
    }
    
    func fetchUserCollection() {
        Task {
            do {
                userCollection = try await interactor.getUserCollection()
            } catch {
                print(error.localizedDescription)
                showAlert = true
            }
        }
    }
    
    func containsInUserCollection(manga: MangaDTO) -> Bool {
        userCollection.contains(where: {$0.manga.id == manga.id})
    }
    
    func removeManga(id: Int) {
        Task {
            do {
                try await interactor.removeFromCollection(mangaID: id)
                
                userCollection.removeAll { manga in
                    manga.manga.id == id
                }
            } catch let error as NetworkError {
                print(error.errorDescription)
            } catch {
                print(error)
            }
        }
    }
}
