//
//  LoginViewModel.swift
//  MangaApp
//
//  Created by Fran Malo on 21/5/24.
//
import SwiftUI

final class LoginViewModel: ObservableObject {
    
    @AppStorage("userLogged") var userLogged = false
    @AppStorage("usernameLoged") private var usernameLoged: String = ""
    @Published var username = ""
    @Published var password = ""
    @Published var passwordConfirm = ""
    @Published var email: String = ""
    @Published var showAlert = false
    @Published var registerOK = false
    @Published var alertMessage = ""
    

    let keyChain = KeychainManager.shared

    var passwordMatch: Bool {
        if password != "" {
            password == passwordConfirm
        }
        else {
            false
        }
    }
    
    let interactor: LoginInteractorProtocol
    
    init(interactor: LoginInteractorProtocol = LoginInteractor.shared) {
        self.interactor = interactor
    }
    
    func registerUser() {
        guard allFieldsCheck() else {
            showAlert = true
            alertMessage = "Empty Fields"
            return
        }

        Task {
            do {
                let user = UserModel(email: email, password: password)
                print(user.email)
                print(user.password)

                try await interactor.registerUser(model: user)
                await MainActor.run {
                    registerOK.toggle()
                }
                
            } catch {
                print(error.localizedDescription)
                await MainActor.run {
                    showAlert = true
                    alertMessage = "Register Failed. Try again later"
                }
            }
        }
    }
    
    func passwordMatchFunc() -> Bool {
        if password != "" {
            return password == passwordConfirm
        }
        else {
            return false
        }
    }
    
    func allFieldsCheck() -> Bool {
        !(username.isEmpty || email.isEmpty || password.isEmpty || passwordConfirm.isEmpty)
    }

    
    func logIn() {
        usernameLoged = email
        Task {
            do {
                let user = UserModel(email: email, password: password)
                try await interactor.loginUser(user: user)
                await MainActor.run {
                    userLogged = true
                }
            } catch {
                print("eerror")
                print(error.localizedDescription + "login")
                await MainActor.run {
                    userLogged = false
                }
            }
        }
    }
    
   
}

