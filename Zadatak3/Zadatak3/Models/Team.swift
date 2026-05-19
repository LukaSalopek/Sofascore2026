//
//  Team.swift
//  Zadatak3
//
//  Created by akademija on 08.05.2026..
//

public struct Team : Codable {
    public let id : Int
    public let name : String
    public let logoUrl : String?
    public let country : Country?
}
