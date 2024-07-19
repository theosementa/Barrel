//
//  EntryAPIRequester.swift
//  Barrel
//
//  Created by KaayZenn on 19/07/2024.
//

import Foundation

enum EntryAPIRequester: APIRequestBuilder {
    case getEntries
    case getEntry(entryID: Int)
    case createEntry(body: EntryBody)
    case deleteEntry(entryID: Int)
}

extension EntryAPIRequester {
    var path: String {
        switch self {
        case .getEntries:
            return NetworkConstant.Path.Entry.entry
        case .getEntry(let entryID):
            return NetworkConstant.Path.Entry.manageEntry(entryID: entryID)
        case .createEntry(_):
            return NetworkConstant.Path.Entry.entry
        case .deleteEntry(let entryID):
            return NetworkConstant.Path.Entry.manageEntry(entryID: entryID)
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getEntries:
            return .GET
        case .getEntry(_):
            return .GET
        case .createEntry(_):
            return .POST
        case .deleteEntry(_):
            return .DELETE
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
        case .createEntry(let body):
            return try? JSONEncoder().encode(body)
        default:
            return nil
        }
    }
}
