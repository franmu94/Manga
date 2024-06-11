//
//  MangaListViewModel.swift
//  MangaApp
//
//  Created by Fran Malo on 30/5/24.
//

import Foundation
//import Combine

enum FilterType: String, CaseIterable, Identifiable {
    var id: Self { self }
    case All
    case Themes
    case Genre
    case Demography
}

final class MangaListViewModel: ObservableObject {
    
    enum MangasGetType {
        case search
        case general
        case filter
    }
    
    var getFilteredOptions: [String] {
        switch filterOption {
        case .All:
            []
        case .Themes:
            Theme.allCases.map { $0.rawValue }
        case .Genre:
            Genre.allCases.map { $0.rawValue }
        case .Demography:
            Demography.allCases.map { $0.rawValue }
        }
    }
    
    //private var disposeBag = Set<AnyCancellable>()
    private var searchWork: DispatchWorkItem?

    let mangaListInteractor: MangaListInteractorProtocol
    var mangaGetType: MangasGetType = .general 
    var errorMessage = ""
    
    @Published var showerror = false
    @Published var mangaList: [MangaDTO] = []
    @Published var searchText: String = "" {
        didSet {
            page = 1
            searchWithDelay()
        }
    }
    
    @Published var filterOption: FilterType = .All
    @Published var selectedTheme: Theme = .gore
    @Published var selectedFilteredOption: String = ""
    var page = 1
    var per = 20
    
    
    init(mangaListInteractor: MangaListInteractorProtocol = MangaListInteractor.shared ) {
        self.mangaListInteractor = mangaListInteractor
        //getMangaList()
        //debounceSearchText()
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
            break
        }
    }
    
    func getFilteredManga() {
    }
    
    func setMangaType() {
       mangaGetType =  if searchText.isEmpty {
            .general
        } else {
            .search
        }
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
   
    /*private func debounceSearchText() {
        $searchText
            .debounce(for: 1, scheduler: RunLoop.main)
            .sink { value in
                self.getMangas()
            }
            .store(in: &disposeBag)
    }*/
    
    private func searchWithDelay() {
        searchWork?.cancel()
        let newSearchWork = DispatchWorkItem {
            self.getMangas()
        }
        searchWork = newSearchWork
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: newSearchWork)
    }
  
    
    /* @MainActor
    func getMangaList2() async {
        do {
            let result = try await mangaListInteractor.fetchMangasList(page: page, per: per).items
            mangaList += result
        } catch {
            print(error)
        }
    } */
}
