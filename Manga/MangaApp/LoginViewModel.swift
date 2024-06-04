//
//  LoginViewModel.swift
//  MangaApp
//
//  Created by Fran Malo on 21/5/24.
//
import SwiftUI

final class LoginViewModel: ObservableObject {
    
    @AppStorage("userLogged") var userLogged = false
    
    @Published var username = ""
    @Published var password = ""
    @Published var passwordConfirm = ""
    @Published var email: String = ""
    @Published var showAlert = false
    @Published var registerOK = false

    let keyChain = SecKeyStore.shared

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
            showAlert.toggle()
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
                print(error)
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
        Task {
            do {
                let user = UserModel(email: email, password: password)
                try await interactor.loginUser(user: user)
                await MainActor.run {
                    userLogged = true
                }
            } catch {
                print(error.localizedDescription)
                await MainActor.run {
                    userLogged = false
                }
            }
        }
    }
    
    func recoverToken() -> String {
        
        guard let data = keyChain.readKey(label: "token") else {
            return ""
        }
        if let token = String(data: data, encoding: .utf8)
        {
            return token
        }
        return ""
    }
}

