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
    
    var isGeneral = true
    
    @Environment (\.dismiss) var dismiss
    @State var showSheet = false
    @ObservedObject var avatarVM = AvatarVM()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(manga.title)
        }
    }
    
}

#Preview {
    MangaListDetailView(manga: .preview)
}
