//
//  FilterListViewArray.swift
//  MangaApp
//
//  Created by Fran Malo on 10/6/24.
//

import SwiftUI

struct FilterListViewArray: View {
    
    @Binding var selectedOption: String
    let filterOptions: [String]
    @Binding var showFilter: Bool

    var body: some View {
        VStack (alignment:.leading) {
            Button {
                showFilter.toggle()
            } label: {
                Text("< Back")
                    .padding()
            }
            
            List {
                ForEach(filterOptions, id: \.self) { filter in
                    Text("\(filter)".capitalized)
                        .font(.title)
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
            .overlay {
                VStack(){
                    Spacer()
                    Button {
                        showFilter.toggle()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.gray.opacity(0.9))
                        
                    }
                }
            }
        }
        .padding(.top, 30)
        .background(.thinMaterial)
    }
}

#Preview {
    FilterListViewArray(selectedOption: .constant(""), filterOptions: Theme.allCases.map { $0.rawValue }, showFilter: .constant(true))
}
