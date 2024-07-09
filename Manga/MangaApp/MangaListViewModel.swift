//
//  MangaListViewModel.swift
//  MangaApp
//
//  Created by Fran Malo on 30/5/24.
//

import Foundation

enum FilterType: String, CaseIterable, Identifiable {
    var id: Self { self }
    case All
    case Themes
    case Genre
    case Demographic
}

final class MangaListViewModel: ObservableObject {
    
    enum MangasGetType {
        case search
        case general
        case filter
    }
    
    var getFilteredOptions: [String] {
        switch filterType {
        case .All:
            []
        case .Themes:
            Theme.allCases.map { $0.rawValue }
        case .Genre:
            Genre.allCases.map { $0.rawValue }
        case .Demographic:
            Demography.allCases.map { $0.rawValue }
        }
    }
    
    let mangaListInteractor: MangaListInteractorProtocol

    var searchTask: Task<Void,Never>?
    var mangaGetType: MangasGetType = .general
    var errorMessage = ""
    var page = 1
    var per = 20
    
    @Published var isLoading: Bool = true
    @Published var showerror = false
    @Published var mangaList: [MangaDTO] = [] {
        didSet {
            isLoading = false
        }
    }
    @Published var searchText: String = "" {
        didSet {
            if oldValue != searchText {
                page = 1
                if !searchText.isEmpty {
                    mangaGetType = .search
                    searchWithDelayAsync()

                } else {
                    mangaGetType = .general
                    getMangas()

                }
            }
        }
    }
    @Published var filterType: FilterType = .All
  
    
    

    @Published var selectedFilteredOption: String = "" {
        didSet {
            if selectedFilteredOption == "" {
                mangaGetType = .general
            } else {
                mangaGetType = .filter
            }
            page = 1
            getMangas()
        }
    }
    
    
    
    init(mangaListInteractor: MangaListInteractorProtocol = MangaListInteractor.shared ) {
        self.mangaListInteractor = mangaListInteractor
        getMangas()
    }
    
    func getMangas() {
        if page == 1 {
            mangaList.removeAll()
        }
        setMangaType()
        switch mangaGetType {
        case .search:
            getMangaSearch()
            
        case .general:
            getMangaList()
            
        case .filter:
            getFilteredMangas()
        }
    }
    
    func getFilteredMangas() {
        Task {
            switch filterType {
            case .All:
                getMangaList()
            case .Themes:
                break
            case .Genre:
                page = 1
                let filterResult = try await mangaListInteractor.fetchMangasByGenre(genre: selectedGenre.rawValue, page: page).items
                await MainActor.run {
                                    self.mangaList = filterResult
                                }
            case .Demographic:
                break
            }
        }
    }
    
    func setMangaType() {
        mangaGetType = searchText.isEmpty ? .general : .search
    }
    
    func getMangaList() {
        Task {
            do {
                let result = try await mangaListInteractor.fetchMangasList(page: page, per: per).items
                await MainActor.run {
                    mangaList += result
                }
            } catch {
                await MainActor.run {
                    setAlert()
                }
            }
        }
    }
    
    func isLastItem(manga: MangaDTO) {
        if mangaList.last?.id == manga.id {
            page += 1
            getMangas()
        }

    }
    func getMangaSearch() {
        Task {
            do {
                let mangaResult = try await mangaListInteractor.fetchMangasContains(name: searchText, page: page).items
                self.mangaList += mangaResult

            } catch let error as NetworkError {
                //print(error.errorDescription)
                await MainActor.run {
                    setAlert()
                }
            } catch {
                //print(error)
                await MainActor.run {
                    setAlert()
                }
            }
        }
    }
    
    private func setAlert(message: String? = nil) {
        errorMessage = message ?? "Can not change the view"
        showerror = true
    }
   
    func searchWithDelayAsync() {
        searchTask?.cancel()
        searchTask = nil
        searchTask = Task { @MainActor in //hace que el getMangas se haga cada cosa en su hilo. como lo del @MainActor arriba encima de la funcion.
            try? await Task.sleep(nanoseconds: 300_000_000) //0.3 segundos
            if Task.isCancelled {
                return
            }
            getMangas()
        }
    }
}
