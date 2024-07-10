//
//  MangaListDetailView.swift
//  MangaApp
//
//  Created by Fran Malo on 10/7/24.
//

import SwiftUI
import CacheImages

struct MangaListDetailView: View {
    
    let manga: MangaDTO
    // para los prooos
    
    var isGeneral = true
    @Binding var path: NavigationPath
    @Environment (\.dismiss) var dismiss
    
    //@Environment(UserCollectionVM.self) var vm


    
    @State var showSheet = false
    
    @ObservedObject var avatarVM = AvatarVM()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(manga.title)
            if let image = avatarVM.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)

            } else {
                Image(systemName: "iphone")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
            }
            if isGeneral {
                Button {
                    showSheet.toggle()
                } label: {
                    if vm.containsInUserCollection(manga: manga) {
                        Text("It is in your collection")
                    } else {
                        Text("Add to collection")
                    }
                }
                .disabled(vm.containsInUserCollection(manga: manga))
            } else {
                Button {
                    vm.removeManga(id: manga.id)
                    dismiss()
                } label: {
                    Text("Remove from collection")
                }
            }

        }
        .sheet(isPresented: $showSheet, content: {
            AddMangaFormView(path: $path, manga: manga)
        })
        .onAppear{
            if let imageURL = manga.mainPictureURL {
                avatarVM.getImage(url: imageURL)
            }
            
        }
        
    }
}

#Preview {
    MangaListDetailView()
}
