//
//  LoginView.swift
//  MangaApp
//
//  Created by Fran Malo on 21/5/24.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var vm = LoginViewModel()
    @State var showRegister = false
    var body: some View {
      
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Login")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 50)

                
                CustomTextfield(texfieldContent: $vm.email, title: "email", prompt: "Email")
                
                CustomTextfield(texfieldContent: $vm.password, title: "Password", prompt: "Password", type: .secure)

                VStack(alignment: .center) {
                    Button(action: {
                        vm.logIn()
                        
                    }, label: {
                        Text("Login")
                            .padding()
                    })
                    
                    Button(action: {
                        showRegister.toggle()
                    }, label: {
                        Text("Create account")
                    })
                    
                  
                }
                .frame(maxWidth: .infinity)
            }
            .safeAreaPadding()
            .navigationDestination(isPresented: $showRegister) {
                CreateAccountView(vm: vm)
            }
        }
    }
}

#Preview {
    LoginView()
}
