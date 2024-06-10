//
//  MAngaListCell.swift
//  MangaApp
//
//  Created by Fran Malo on 5/6/24.
//

import SwiftUI
import CacheImages

struct MangaListCell: View {
    let manga: MangaDTO
    @ObservedObject var vm = AvatarViewModel()

    var body: some View {
        HStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
            } else {
                Image(systemName: "popcorn")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
            }
            VStack(alignment: .leading) {
                Text(manga.title)
                Text(String(manga.score))
            }
            .padding()
            
        }
        .onAppear{
            if let imageURL = manga.mainPictureURL {
                vm.getImage(url: imageURL)
            }
        }
    }
}

#Preview {
    NavigationStack{
        MangaListCell(manga: .preview)
    }
}
