//
//  LoginResponse.swift
//  Zadatak3
//
//  Created by akademija on 08.05.2026..
//

public struct LoginResponse: Codable {
    public let name: String
    public let token: String
    
    public init(name: String, token: String) {
        self.name = name
        self.token = token
    }
}
