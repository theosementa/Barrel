//
//  KeychainManager.swift
//  Essential
//
//  Created by Theo Sementa on 12/03/2024.
//

import Foundation
import Security
import LocalAuthentication

struct Credentials {
    var email: String
    var password: String
}

enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}

enum KeychainServiceManager: String {
    case token = "token"
}

class KeychainManager {
    static let shared = KeychainManager()
}

extension KeychainManager {
    
    func retrieveItem(service: KeychainServiceManager) -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: service.rawValue,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ] as CFDictionary
                
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        
        if let result = result as? NSDictionary {
            if let itemData = result[kSecValueData] as? Data {
                let item = String(data: itemData, encoding: .utf8)!
                return item
            }
        }
        
        return nil
    }
    
    func setItemToKeychain(newValue: String, service: KeychainServiceManager) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: service.rawValue,
            kSecValueData: newValue.data(using: .utf8)!,
        ] as CFDictionary
        
        var status = SecItemAdd(query, nil)
                
        if status == errSecDuplicateItem {
            // Item already exist, thus update it.
            let updateQuery = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount as String: service.rawValue
            ] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: newValue.data(using: .utf8)!] as CFDictionary
            status = SecItemUpdate(updateQuery, attributesToUpdate)
        }
    }
}


// MARK: - Credentials
extension KeychainManager {
    
    func setCredentials(credentials: Credentials) throws {
        let server = "https://split-app.fr/"
        let account = credentials.email
        let password = credentials.password.data(using: String.Encoding.utf8)!
        var query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrAccount as String: account,
                                    kSecAttrServer as String: server,
                                    kSecValueData as String: password]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
    
    func retrieveCredentials() -> Credentials? {
        let server = "https://split-app.fr/"
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: server,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { return nil }
        guard status == errSecSuccess else { return nil }
        
        guard let existingItem = item as? [String : Any],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8),
            let account = existingItem[kSecAttrAccount as String] as? String
        else { return nil }
        
        let credentials = Credentials(email: account, password: password)
        return credentials
    }
    
}
