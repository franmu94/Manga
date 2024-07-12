//
//  URLRequest.swift
//  MangaApp
//
//  Created by Fran Malo on 22/5/24.
//

import Foundation
extension URLRequest {
    
    static func refreshToken(url: URL, userToken: String, apiPassword: String?) -> URLRequest {
        var request = URLRequest(url: url)
        
        let auth = "Bearer \(userToken)"
        
        request.httpMethod = "POST"
        request.setValue(auth, forHTTPHeaderField: "Authorization")
        request.setValue(apiPassword, forHTTPHeaderField: "App-Token")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json: charset=utf-8", forHTTPHeaderField: "Authorization")

        return request
    }
    
    static func getUserCollection(url: URL, userToken: String, apiPassword: String?) -> URLRequest {
        var request = URLRequest(url: url)
        
        let auth = "Bearer \(userToken)"
        request.setValue(auth, forHTTPHeaderField: "Authorization")
        
        request.setValue(apiPassword, forHTTPHeaderField: "App-Token")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        return request
    }
    
    static func post(model: UserModel, apiPassword: String?, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        
        let credentials = "\(model.email):\(model.password)"
        
        if let encodedCredentials = credentials.data(using: .utf8) {
            let auth = "Basic \(encodedCredentials.base64EncodedString())"
            
            request.setValue(auth, forHTTPHeaderField: "Authorization")
        }
        
        request.httpMethod = "POST"
        request.setValue(apiPassword, forHTTPHeaderField: "App-Token")// Codigo fijo que tiene esta api
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONEncoder().encode(model)
        return request
        
    }
    
    static func postCollection(model: MangaCollectionModel, apiPassword: String?, url: URL, userToken: String) -> URLRequest  {
        var request = URLRequest(url: url)

        let auth = "Bearer \(userToken)"
        request.setValue(auth, forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "POST"
        
        request.setValue(apiPassword, forHTTPHeaderField: "App-Token")// Codigo fijo que tiene esta api
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONEncoder().encode(model)
        return request
    }
    
    static func removeFromCollection(userToken: String, url: URL, apiPassword: String?)  -> URLRequest {
        
        var request = URLRequest(url: url)
        print(request.url ?? "")
        
        let auth = "Bearer \(userToken)"
        request.setValue(auth, forHTTPHeaderField: "Authorization")

        request.httpMethod = "DELETE"
        
        request.setValue(apiPassword, forHTTPHeaderField: "App-Token")// Codigo fijo que tiene esta api
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        return request
    }
    
}
