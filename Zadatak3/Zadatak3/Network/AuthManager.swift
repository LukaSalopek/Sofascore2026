//
//  AuthManager.swift
//  Zadatak3
//
//  Created by akademija on 24.05.2026..
//

import Foundation
import Security

final class AuthManager {
    
    static let shared = AuthManager()
    private init() {}
    
    private let tokenKey = "auth_token"
    private let userNameKey = "user_name"
    
    var isLoggedIn : Bool {
        return getToken() != nil
    }
    
    func saveToken(_ token : String, userName : String) {
        UserDefaults.standard.set(userName, forKey: userNameKey)
        let query: [String:Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : tokenKey,
            kSecValueData as String: token.data(using: .utf8)!
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result : AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess, let data = result as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func getUserName() -> String? {
        return UserDefaults.standard.string(forKey: userNameKey)
    }
    
    func logout(){
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey
        ]
        SecItemDelete(query as CFDictionary)
        UserDefaults.standard.removeObject(forKey: userNameKey)
    }
    
}
