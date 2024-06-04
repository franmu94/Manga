//
//  MangaListView.swift
//  MangaApp
//
//  Created by Fran Malo on 30/5/24.
//

import SwiftUI

struct MangaListView: View {
    @ObservedObject var vm = MangaListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.mangaList) { manga in
                    NavigationLink(value: manga) {
                        Text(manga.title)
                            .onAppear{
                                vm.isLastItem(manga: manga)
                            }
                    }
                }
            }
            .searchable(text: $vm.searchText)
            .navigationTitle("Mangas")
            .navigationDestination(for: MangaDTO.self) { manga in
                //
                Text(manga.title)
            }
            
        }
        
        
    }
}

#Preview {
    //MangaListView(vm: .previewVM)
    MangaListView.preview
}
