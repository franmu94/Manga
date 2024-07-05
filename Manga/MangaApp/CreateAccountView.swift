//
//  CreateAccountView.swift
//  MangaApp
//
//  Created by Fran Malo on 21/5/24.
//

import SwiftUI

struct CreateAccountView: View {
    @ObservedObject var vm: LoginViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Create Account")
                .font(.title)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 50)
            
            CustomTextfield(texfieldContent: $vm.username, title: "Username", prompt: "Username")

            CustomTextfield(texfieldContent: $vm.email, borderColor: vm.email.isValidEmail() ? .green : .clear, title: "Email", prompt: "Email")

        
            CustomTextfield(texfieldContent: $vm.password, title: "Password", prompt: "Password", type: .secure)
            
            CustomTextfield(texfieldContent: $vm.passwordConfirm, borderColor: vm.passwordMatch ? .green : .clear, title: "Repeat password", prompt: "Password", type: .secure)

            VStack(alignment: .center) {
                
                Button(action: {
                    vm.registerUser()
                }, label: {
                    Text("Create account")
                })
            }
            .frame(maxWidth: .infinity)
            
        }
        .onChange(of: vm.registerOK) {
            dismiss()
        }
        .safeAreaPadding()
        .alert(vm.alertMessage, isPresented: $vm.showAlert) {}

    }
}

#Preview {
    CreateAccountView(vm: LoginViewModel())
}
