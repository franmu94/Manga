//
//  CustomTextfield.swift
//  MangaApp
//
//  Created by Fran Malo on 21/5/24.
//

import SwiftUI


struct CustomTextfield: View {
    
    enum TexfieldType {
        case secure
        case nonSecure
    }
    @Binding var texfieldContent: String
    
    var borderColor: Color = .clear
    let title: String
    let prompt: String
    var type: TexfieldType = .nonSecure
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            Group {
                switch type {
                case .secure:
                    SecureField(title, text: $texfieldContent, prompt: Text(prompt))
                case .nonSecure:
                    TextField(title, text: $texfieldContent, prompt: Text(prompt))
                }
            }
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 4)
                    .fill(borderColor)
            }
        }
        .textFieldStyle(.roundedBorder)
        .autocorrectionDisabled()
        .padding(.bottom)
        
        
    }
}

#Preview {
    CustomTextfield(texfieldContent: .constant(""), title: "Descripcion", prompt: "esto es el prompt")
}
