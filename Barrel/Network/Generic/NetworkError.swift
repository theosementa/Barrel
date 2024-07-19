//
//  NetworkError.swift
//  Essential
//
//  Created by KaayZenn on 09/03/2024.
//

import Foundation

public enum NetworkError: Error, LocalizedError, Equatable {
    case notFound
    case unauthorized
    case badRequest
    case parsingError
    case fieldIsIncorrectlyFilled
    case internalError
    case refreshTokenFailed
    case noConnection
    case unknown
    case custom(message: String)
    
    var banner: Banner {
        switch self {
        case .notFound:
            return Banner.NetworkError.notFoundError
        case .unauthorized:
            return Banner.NetworkError.unauthorizedError
        case .badRequest:
            return Banner.NetworkError.badRequestError
        case .parsingError:
            return Banner.NetworkError.parsingError
        case .fieldIsIncorrectlyFilled:
            return Banner.NetworkError.fieldIsIncorrectlyFilledError
        case .internalError:
            return Banner.NetworkError.internalError
        case .refreshTokenFailed:
            return Banner.NetworkError.refreshTokenFailedError
        case .noConnection:
            return Banner.NetworkError.noConnectionError
        case .unknown:
            return Banner.NetworkError.unknownError
        case .custom(let message):
            return Banner(title: message.localized, style: .error)
        }
    }
}

func mapResponse(response: (data: Data, response: URLResponse, method: String?)) throws -> Data {
    
    guard let httpResponse = response.response as? HTTPURLResponse else {
        return response.data
    }
    
    if let url = httpResponse.url {
        print("🛜 \(response.method ?? "") | \(httpResponse.statusCode) -> \(url)")
    }
    
    switch httpResponse.statusCode {
    case 200..<300:
        return response.data
    case 400:
        throw NetworkError.badRequest
    case 401:
        throw NetworkError.unauthorized
    case 404:
        throw NetworkError.notFound
    case 422:
        throw NetworkError.fieldIsIncorrectlyFilled
    case 500:
        throw NetworkError.internalError
    case 503:
        throw NetworkError.internalError
    default:
        throw NetworkError.unknown
    }
    
}
