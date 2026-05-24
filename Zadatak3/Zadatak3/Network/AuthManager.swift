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

    var isLoggedIn: Bool {
        return getToken() != nil
    }

    @discardableResult
    func saveToken(_ token: String, userName: String) -> Bool {
        UserDefaults.standard.set(userName, forKey: userNameKey)

        guard let tokenData = token.data(using: .utf8) else { return false }

        let deleteQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey
        ]
        SecItemDelete(deleteQuery as CFDictionary)

        let addQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey,
            kSecValueData as String: tokenData,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]
        let status = SecItemAdd(addQuery as CFDictionary, nil)

        if status != errSecSuccess {
            print("⚠️ saveToken failed, OSStatus = \(status)")
            return false
        }
        return true
    }

    func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess else {
            if status != errSecItemNotFound {
                print("⚠️ getToken failed, OSStatus = \(status)")
            }
            return nil
        }
        guard let data = result as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }

    func getUserName() -> String? {
        return UserDefaults.standard.string(forKey: userNameKey)
    }

    func logout() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey
        ]
        SecItemDelete(query as CFDictionary)
        UserDefaults.standard.removeObject(forKey: userNameKey)
    
        try? DatabaseManager.shared.clearAll()
    }
}
