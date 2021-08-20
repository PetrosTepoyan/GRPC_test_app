//
// Category.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

public struct CategoryGrade: Codable {
    public var id: Int?
    public var name: String
    public var codeName: String?
    public var section: Int
    public var is_system: Bool?
    public var is_current: Bool?
    public var visible: Bool?
    public var sort_order: Int?
    public var created_at: String?
    public var updated_at: String?
    public var chats: [Chat]?
    
    public init(id: Int? = nil, name: String, codeName: String? = nil, section: Int, is_system: Bool? = false, is_current: Bool? = false, visible: Bool? = true, sort_order: Int? = 0, created_at: String? = nil, updated_at: String? = nil, chats: [Chat]? = nil) {
        self.id = id
        self.name = name
        self.codeName = codeName
        self.section = section
        self.is_system = is_system
        self.is_current = is_current
        self.visible = visible
        self.sort_order = sort_order
        self.created_at = created_at
        self.updated_at = updated_at
        self.chats = chats
    }
    
    public init(name: String, section: Int, is_current: Bool? = false, visible: Bool? = true, sort_order: Int? = 0) {
        self.id = nil
        self.name = name
        self.codeName = nil
        self.section = section
        self.is_system = nil
        self.is_current = is_current
        self.visible = visible
        self.sort_order = sort_order
        self.created_at = nil
        self.updated_at = nil
        self.chats = nil
    }
    
    public enum CodingKeys: String, CodingKey { 
        case id = "id"
        case name
        case codeName = "code_name"
        case section
        case is_system
        case is_current
        case visible
        case sort_order
        case created_at
        case updated_at
        case chats
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        codeName = try container.decodeIfPresent(String.self, forKey: .codeName)
        section = try container.decode(Int.self, forKey: .section)
        is_system = try container.decodeIfPresent(Bool.self, forKey: .is_system)
        is_current = try container.decodeIfPresent(Bool.self, forKey: .is_current)
        visible = try container.decodeIfPresent(Bool.self, forKey: .visible)
        sort_order = try container.decodeIfPresent(Int.self, forKey: .sort_order)
        created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        chats = try container.decodeIfPresent([Chat].self, forKey: .chats)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(codeName, forKey: .codeName)
        try container.encodeIfPresent(section, forKey: .section)
        try container.encodeIfPresent(is_system, forKey: .is_system)
        try container.encodeIfPresent(is_current, forKey: .is_current)
        try container.encodeIfPresent(visible, forKey: .visible)
        try container.encodeIfPresent(sort_order, forKey: .sort_order)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encodeIfPresent(chats, forKey: .chats)
    }

}
