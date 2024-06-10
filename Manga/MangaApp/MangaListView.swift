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
                        MangaListCell(manga: manga)
                            .onAppear {
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
            .alert("Something went wrong", isPresented: $vm.showerror) {
                Text("OK")
                Button(action: {
                    vm.getMangas()
                }, label: {
                    Text("Retry")
                })
            } message: {
                Text(vm.errorMessage)
            }

        }
        
        
    }
}

#Preview {
    //MangaListView(vm: .previewVM)
    MangaListView.preview
}
