//
//  PreviewData.swift
//  MangaApp
//
//  Created by Fran Malo on 30/5/24.
//

import SwiftUI

struct MangaListInteractorPreview: MangaListInteractorProtocol {
    func fetchMangasContains(name: String, page: Int) async throws -> MangaResultDTO {
        let url = Bundle.main.url(forResource: "PreviewDataMangas", withExtension: "json")!
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormatCustom)
        return try decoder.decode(MangaResultDTO.self, from: data)    }
    
     
    
    func fetchMangasList(page: Int, per: Int = 20) async throws -> MangaResultDTO {
        
        let url = Bundle.main.url(forResource: "PreviewDataMangas", withExtension: "json")!
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormatCustom)
        return try decoder.decode(MangaResultDTO.self, from: data)
    }
}


extension MangaListViewModel {
    static let previewVM = MangaListViewModel(mangaListInteractor: MangaListInteractorPreview())
}

extension MangaListView {
    static var preview: some View {
        MangaListView(vm: .previewVM)
    }
}
