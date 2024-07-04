//
//  NetworkError.swift
//  MangaApp
//
//  Created by Fran Malo on 22/5/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case general(Error)
    case status(Int)
    case json(Error)
    case dataNotValid
    case nonHTTP
    case errorAddingManga
    case errorRemovingManga
    
    var errorDescription: String? {
        switch self {
        case .general(let error):
            "Error general: \(error.localizedDescription)"
        case .status(let int):
            "Error de status \(int)."
        case .json(let error):
            "Error de JSON: \(error)."
        case .dataNotValid:
            "Error, dato no valido"
        case .nonHTTP:
            "No es una conexion HTTP"
        case .errorAddingManga:
            "Can not add Manga."
        case .errorRemovingManga:
            "Error removing manga"
            
        }
    }
}
