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
        NavigationStack(path: $navigationPath) {
            Group {
                if vm.isLoading {
                    ProgressView()
                        .controlSize(.large)
                } else {
                    List {
                        // para ver si una vista cambia alguna cosa.
                        // let _ = MangaListView._printChanges()
                        if vm.isLoading {
                            ProgressView()
                                .controlSize(.large)
                        } else if vm.mangaList.isEmpty {
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
                            } else {
                                vm.selectedFilterOptions = ""
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
                MangaListDetailView(manga: manga, path: $navigationPath)
            }
            .alert(Text("Something went wrong"), isPresented: $vm.showError) {
                Button(action: {
                }, label: {
                    Text("Ok")
                })
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
                FilterListViewArray(selectedFilter: $vm.selectedFilterOptions, filterOptions: vm.getFilteredOptions, showFilter: $showFilterView)
            }
        }
    }
}

#Preview {
    //MangaListView(vm: .previewVM)
    MangaListView.preview
}
