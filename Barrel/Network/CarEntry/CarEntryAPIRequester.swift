//
//  CarEntryAPIRequester.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import Foundation

enum CarEntryAPIRequester: APIRequestBuilder {
    case getEntry(id: Int)
    case edit(id: Int, body: CarEntry)
    case delete(id: Int)
    case create(body: CarEntry)
}

extension CarEntryAPIRequester {
    var path: String {
        switch self {
        case .getEntry(let id): return NetworkPath.Entry.get(id)
        case .edit(let id, _):  return NetworkPath.Entry.edit(id)
        case .delete(let id):   return NetworkPath.Entry.delete(id)
        case .create:           return NetworkPath.Entry.create
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getEntry: return .GET
        case .edit:     return .PUT
        case .delete:   return .DELETE
        case .create:   return .POST
        }
    }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
    
    var isTokenNeeded: Bool {
        return true
    }
    
    var body: Data? {
        switch self {
        case .getEntry, .delete: return nil
        case .create(let body): return try? JSONEncoder().encode(body)
        case .edit(_, let body): return try? JSONEncoder().encode(body)
        }
    }
}
