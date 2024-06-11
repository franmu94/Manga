//
//  FilterListView.swift
//  MangaApp
//
//  Created by Fran Malo on 10/6/24.
//

import SwiftUI

struct FilterListView<T:CaseIterable & Hashable & Identifiable>: View {
    
    @Binding var selectedFilter: T
    @Binding var showFilter: Bool
    
    var body: some View {
        VStack (alignment:.leading) {
            List {
                ForEach(Array(T.allCases)) { filter in
                    Text("\(filter)".capitalized)
                        .font(.title)
                        .bold()
                        .onTapGesture {
                            selectedFilter = filter
                            showFilter.toggle()
                        }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .background(.thinMaterial)
        
    }
}

#Preview {
    FilterListView(selectedFilter: .constant(Theme.combatSports), showFilter: .constant(Bool()))
}
