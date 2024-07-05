//
//  MangaAppApp.swift
//  MangaApp
//
//  Created by Fran Malo on 20/5/24.
//

import SwiftUI

@main
struct MangaAppApp: App {
    
    @AppStorage("userLogged") var userLogged = false // no lo sobreescribe

    @StateObject var listVM = MangaListViewModel()
    
    var body: some Scene {
        WindowGroup {
            if userLogged {
                MainTabView()
                    .environmentO(listVM)
            } else {
                LoginView()
            }
        }
    }
}





