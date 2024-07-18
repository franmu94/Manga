//
//  MangaListView.swift
//  MangaApp
//
//  Created by Fran Malo on 30/5/24.
//

import SwiftUI

struct MangaListView: View {
    @EnvironmentObject var vm: MangaListViewModel
    
    @State var showFilterView: Bool = false
    @State var navigationPath = NavigationPath()
    
    var body: some View {
        if vm.isLoading {
            ProgressView()
                .controlSize(.large)
        } else {
            List {
                ForEach(vm.mangaList) {manga in
                    MangaListCell(manga: manga)
                }
            }
        }
    }
}

#Preview {
    //MangaListView(vm: .previewVM)
    MangaListView.preview
}
