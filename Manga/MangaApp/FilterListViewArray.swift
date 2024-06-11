//
//  FilterListViewArray.swift
//  MangaApp
//
//  Created by Fran Malo on 10/6/24.
//

import SwiftUI

struct FilterListViewArray: View {
    
    //@Binding var selectedFilter: T
    let filterOptions: [String]
    @Binding var showFilter: Bool
    @Binding var selectedOption: String
    
    var body: some View {
        VStack (alignment:.leading) {
            List {
                ForEach(filterOptions, id: \.self) { filter in
                    Text("\(filter)".capitalized)
                        .font(.title2)
                        .foregroundStyle(.secondary)
                        .onTapGesture {
                            selectedOption = filter
                            showFilter.toggle()
                        }
                    
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            Button {
                showFilter.toggle()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .padding(.top, 30)
        .background(.thinMaterial)
        
    }
}

#Preview {
    FilterListViewArray(filterOptions: Theme.allCases.map { $0.rawValue }, showFilter: .constant(true), selectedOption: .constant(""))
}
