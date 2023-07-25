//
//  KeychainHelper.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 06/06/23.
//

import Foundation

final class KeychainHelper {
    static let standard = KeychainHelper()
    private init() {}
    
    func save<T>(_ item: T, service: String, account: String) -> Bool where T : Codable {
        
        do {
            // Encode as JSON data and save in keychain
            let data = try JSONEncoder().encode(item)
            return save(data, service: service, account: account)
            
        } catch {
            assertionFailure("Fail to encode item for keychain: \(error)")
            return false
        }
    }
    
    func read<T>(service: String, account: String, type: T.Type) -> T? where T : Codable {
        
        // Read item data from keychain
        guard let data = read(service: service, account: account) else {
            return nil
        }
        
        // Decode JSON data to object
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
    
    func delete(service: String, account: String) {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
        
        // Delete item from keychain
        SecItemDelete(query)
    }
    
    func deleteAll() {
        let status = SecItemDelete([
            kSecClass: kSecClassGenericPassword
        ] as NSDictionary)
        guard status == errSecSuccess else {
            print("Keychain deletion error")
            return
        }
    }
}

fileprivate extension KeychainHelper {
    private func save(_ data: Data, service: String, account: String) -> Bool {
        // Create query
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
        ] as CFDictionary
        
        // Add data in query to keychain
        let status = SecItemAdd(query, nil)
        
        if status == errSecDuplicateItem {
            // Item already exist, thus update it.
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            
            // Update existing item
            SecItemUpdate(query, attributesToUpdate)
            return true
        }
        
        if status != errSecSuccess {
            // Print out the error
            print("Error: \(status)")
            return false
        }
        return true
    }
    
    func read(service: String, account: String) -> Data? {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true,
            kSecMatchLimit as String : kSecMatchLimitOne
        ] as CFDictionary
          
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == noErr,
           let data = dataTypeRef as? Data {
            return data
        } else {
            return nil
        }
    }
}
