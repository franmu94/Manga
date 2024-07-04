//
//  MainTabView.swift
//  MangaApp
//
//  Created by Fran Malo on 30/5/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MangaListView()
                .tabItem {
                    Label("General", systemImage: "square.and.pencil")
                }
            Text("Adios")
                .tabItem {
                    Label("Collection", systemImage: "square.and.pencil")
                }
            Text("Adios")
                .tabItem {
                    Label("Top", systemImage: "square.and.pencil")
                }
            SettingView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    MainTabView()
}

