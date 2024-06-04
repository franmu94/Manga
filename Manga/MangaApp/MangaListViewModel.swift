//
//  MangaListViewModel.swift
//  MangaApp
//
//  Created by Fran Malo on 30/5/24.
//

import Foundation
import Combine



final class MangaListViewModel: ObservableObject {
    
    enum MangasGetType {
        case search
        case general
        case filter
    }
    
    private var disposeBag = Set<AnyCancellable>()

    let mangaListInteractor: MangaListInteractorProtocol
    var mangaGetType: MangasGetType = .general 
    
    @Published var mangaList: [MangaDTO] = []
    @Published var searchText: String = "" {
        didSet {
            page = 1
        }
    }
    var page = 1
    var per = 20
    
    
    init(mangaListInteractor: MangaListInteractorProtocol = MangaListInteractor.shared ) {
        self.mangaListInteractor = mangaListInteractor
        //getMangaList()
        debounceSearchText()
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
                print(error)
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
                await MainActor.run {
                    self.mangaList += mangaResult
                }
            } catch let error as NetworkError {
                print(error.errorDescription)
            } catch {
                print(error)
            }
        }
    }
    
    private func debounceSearchText() {
        $searchText
            .debounce(for: 1, scheduler: RunLoop.main)
            .sink { value in
                self.getMangas()
            }
            .store(in: &disposeBag)
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
