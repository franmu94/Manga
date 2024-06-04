//
//  NetworkInteractor.swift
//  MangaApp
//
//  Created by Fran Malo on 22/5/24.
//

import Foundation
//MARK: Protocolo a revisar
protocol LoginInteractorProtocol {
    func registerUser(model: UserModel) async throws
    func loginUser(user: UserModel) async throws
}




struct LoginInteractor: LoginInteractorProtocol {
    static let shared = LoginInteractor()
    let appConfing = AppConfig.shared
    let keyChain = SecKeyStore.shared

    func registerUser(model: UserModel) async throws {
        
        let (_, response) = try await URLSession.shared.data(for: .post(model: model, apiPassword: appConfing.APIKey, url: .userRegisterURL))
        
        guard let responseHTTP = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTP
        }
        if responseHTTP.statusCode != 201 {
            throw NetworkError.status(responseHTTP.statusCode)
        }
        
    }
    
    func loginUser(user: UserModel) async throws {
        let (data, response) = try await URLSession.shared.data(for: .post(model: user, apiPassword: appConfing.APIKey, url: .userLoginURL))
        
        guard let responseHTTP = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTP
        }
        
        guard responseHTTP.statusCode == 200 else {
            throw NetworkError.status(responseHTTP.statusCode)
        }
        
        keyChain.storeKey(key: data, label: "token")
    }
}
