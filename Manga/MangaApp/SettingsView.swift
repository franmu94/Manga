//
//  SettingsView.swift
//  MangaApp
//
//  Created by Fran Malo on 4/7/24.
//

import SwiftUI

struct SettingView: View {
    
    @AppStorage("userLogged") var userLogged = true
    @AppStorage("usernameLoged")  var username: String = ""

    
    var body: some View {
        
        VStack {
            Text("Welcome, \(username)")
            Button {
                userLogged = false
            } label: {
                Text("Logout")
            }
        }

    }
}

#Preview {
    SettingView()
}
