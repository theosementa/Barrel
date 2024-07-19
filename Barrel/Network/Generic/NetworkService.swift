//
//  NetworkService.swift
//  Essential
//
//  Created by KaayZenn on 09/03/2024.
//

import Foundation

// Protocole
public protocol NetworkServiceProtocol {
    func sendRequest<T: Decodable>(apiBuilder: APIRequestBuilder, responseModel: T.Type) async throws -> T
}

// Implémentation du service de réseau
public class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    private var retryCount = 0
    private let maxRetries = 2
    
    // Méthode publique conforme au protocole
    public func sendRequest<T: Decodable>(apiBuilder: APIRequestBuilder, responseModel: T.Type) async throws -> T {
        do {
            return try await self.sendRequest(apiBuilder: apiBuilder, responseModel: responseModel, retryCount: 0)
        } catch {
            // Réinitialise le compteur de tentatives après une demande réussie ou une erreur
            self.retryCount = 0
            throw error
        }
    }
    
    // Méthode privée avec logique de tentative de reconnexion
    private func sendRequest<T: Decodable>(apiBuilder: APIRequestBuilder, responseModel: T.Type, retryCount: Int) async throws -> T {
        do {
            guard let urlRequest = apiBuilder.urlRequest else {
                throw NetworkError.badRequest
            }
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let dataToDecode = try mapResponse(response: (data, response, urlRequest.httpMethod))
            
            self.retryCount = 0
            
            return try decodeResponse(dataToDecode: dataToDecode, responseModel: responseModel)
        } catch let error as NetworkError {
            if error == .unauthorized {
                if self.retryCount < maxRetries {
                    self.retryCount += 1
                    try await TokenManager.shared.refreshToken()
                    return try await self.sendRequest(apiBuilder: apiBuilder, responseModel: responseModel, retryCount: self.retryCount)
                } else {
                    self.retryCount = 0 // Réinitialise le compteur de tentatives après le maximum de tentatives
                    throw NetworkError.refreshTokenFailed
                }
            } else {
                throw error
            }
        }
    }
    
    private func decodeResponse<T: Decodable>(dataToDecode: Data, responseModel: T.Type) throws -> T {
        do {
            let results = try JSONDecoder().decode(responseModel, from: dataToDecode)
            return results
        } catch {
            print("⚠️ PARSING ERROR : \(error.localizedDescription)")
            throw NetworkError.parsingError
        }
    }
}
