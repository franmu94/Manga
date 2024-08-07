//
//  UserCollectionView.swift
//  MangaApp
//
//  Created by Fran Malo on 7/8/24.
//

import SwiftUI

struct UserCollectionView: View {
    @AppStorage("userLogged") var userLogged = false
    
    @Environment(UserCollectionVM.self) var vm

    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    UserCollectionView()
}
