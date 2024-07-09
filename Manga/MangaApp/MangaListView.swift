//
//  MangaListView.swift
//  MangaApp
//
//  Created by Fran Malo on 30/5/24.
//

import SwiftUI

struct MangaListView: View {
    @ObservedObject var vm = MangaListViewModel()
    
    @State var showFilterView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                if vm.mangaList.isEmpty {
                    ContentUnavailableView("Manga Not Found", systemImage: "book.fill", description: Text("Any manga contains \(vm.searchText)"))
                }
                ForEach(vm.mangaList) { manga in
                    NavigationLink(value: manga) {
                        MangaListCell(manga: manga)
                            .onAppear {
                                vm.isLastItem(manga: manga)
                            }
                    }
                }
            }
            // MARK: refactor
            .toolbar {
                Menu {
                    ForEach(FilterType.allCases) { filter in
                        Button {
                            vm.filterType = filter
                            if filter != .All {
                                showFilterView.toggle()
                            }
                        } label: {
                            Text(filter.rawValue.capitalized)
                        }

                    }
                    
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
            }
            .searchable(text: $vm.searchText)
            .navigationTitle("Mangas")
            .navigationDestination(for: MangaDTO.self) { manga in
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
        .overlay {
            if showFilterView {
                FilterListViewArray(filterOptions: vm.getFilteredOptions, showFilter: $showFilterView, selectedOption: $vm.selectedFilteredOption)
            }
            
        }
        .animation(.bouncy(duration: TimeInterval(0.5)), value: showFilterView)
    }
}

#Preview {
    //MangaListView(vm: .previewVM)
    MangaListView.preview
}
