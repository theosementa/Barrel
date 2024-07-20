//
//  NetworkService.swift
//  Essential
//
//  Created by KaayZenn on 09/03/2024.
//

import Foundation

public protocol NetworkServiceProtocol {
    func sendRequest<T: Decodable>(apiBuilder: APIRequestBuilder, responseModel: T.Type) async throws -> T
}

public class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    
    public func sendRequest<T: Decodable>(apiBuilder: APIRequestBuilder, responseModel: T.Type) async throws -> T {
        do {
            guard let urlRequest = apiBuilder.urlRequest else {
                throw NetworkError.badRequest
            }
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let dataToDecode = try mapResponse(response: (data, response, urlRequest.httpMethod))
                        
            return try decodeResponse(dataToDecode: dataToDecode, responseModel: responseModel)
        } catch let error as NetworkError {
            throw error
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
