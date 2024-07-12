//
//  AppConfig.swift
//  MangaApp
//
//  Created by Fran Malo on 22/5/24.
//

import Foundation

final class AppConfig {
    static let shared = AppConfig()
    
    let keychainManager = KeychainManager.shared
    
    var APIKey: String?
    
    var userToken: String {
        recoverToken()
    }
    
    init() {
        try? getApiKey()
    }
    
    func getApiKey() throws {
        guard let url = Bundle.main.url(forResource: "configAPI", withExtension: "plist") else { return }
        let data = try Data(contentsOf: url)
        
        let plist = try PropertyListDecoder().decode([String: String].self, from: data)
        APIKey = plist["Api_Key"]
        
    }
    
    func recoverToken() -> String {
        
        guard let data = KeychainManager.shared.readKey(label: "token"), let token = String(data:data, encoding: .utf8) else { return "" }
        
        return token
    }
    
    func refreshToken() async throws {
        let (data, _) = try await URLSession.shared.data(for: .refreshToken(url: .userRenewURL, userToken: userToken, apiPassword: APIKey))
        keychainManager.storeKey(key: data, label: "token")
    }
}


