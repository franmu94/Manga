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
    
    init(showAlert: Bool = false, userCollection: [UserCollectionManga], interactor: MangaUserCollectionInteractorProtocol) {
        self.showAlert = showAlert
        self.userCollection = userCollection
        self.interactor = interactor
    }
}
