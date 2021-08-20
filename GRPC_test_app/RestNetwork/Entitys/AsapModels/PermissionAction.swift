//
//  PermissionAction.swift
//  
//
//  Created by Алексей Плакош on 21.07.2021.
//

import Foundation

public struct PermissionAction: Codable {
    public var id: Int?
    public var name: String
    public var codename: String
    
    public init(id: Int? = nil, name: String, codename: String) {
        self.id = id
        self.name = name
        self.codename = codename
    }
    
    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case codename
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        codename = try container.decode(String.self, forKey: .codename)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(codename, forKey: .codename)
    }

}
