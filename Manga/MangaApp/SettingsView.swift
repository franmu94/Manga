//
//  SettingsView.swift
//  MangaApp
//
//  Created by Fran Malo on 4/7/24.
//

import SwiftUI

struct SettingView: View {
    
    @AppStorage("userLogged") var userLogged = true
    
    var body: some View {
        Button {
            userLogged = false
        } label: {
            Text("Log Out")
        }

    }
}

#Preview {
    SettingView()
}
