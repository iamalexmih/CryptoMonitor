//
//  ApiError.swift
//  infoCrypto
//
//  Created by Алексей Попроцкий on 28.01.2023.
//

import Foundation

enum ApiError: Error, CustomStringConvertible {
    case badUrl
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    // MARK: - информация для отладки (разработчика)
    var description: String {
        switch self {
        case .badUrl: return "ошибка с URL"
        case .badResponse(statusCode: let statusCode):
            return "Плохой ответ со статусом: \(statusCode)"
        case .url(let error):
            return error?.localizedDescription ?? "ошибка URLSession"
        case .parsing(let error):
            return "Oшибка парисинга:" + (error?.localizedDescription ?? "")
        case .unknown: return "неизвестная ошибка"
        }
    }
    
    // MARK: - информация для пользователя

    var localizeDescription: String {
        switch self {
        case .badUrl, .parsing, .unknown:
            return "Извините, что то не так"
        case .badResponse(_):
            return "Извините, нет соединения с сервером"
        case .url(let error):
            return error?.localizedDescription ?? "Извините, что то не так адресом"
        }
    }
}
