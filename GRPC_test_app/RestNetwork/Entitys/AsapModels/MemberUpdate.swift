//
//  File.swift
//  
//
//  Created by Алексей Плакош on 21.07.2021.
//

import Foundation

public struct MemberUpdate: Codable {
    public var chat: Int?
    public var user: Int?
    public var isOwner: Bool?
    public var role: String?
    
    public init(chat: Int? = nil, user: Int? = nil, isOwner: Bool? = true, role: String? = MemberRole.owner.rawValue) {
        self.chat = chat
        self.user = user
        self.isOwner = isOwner
        self.role = role
    }
    
    public enum CodingKeys: String, CodingKey {
        case chat
        case user
        case isOwner = "is_owner"
        case role
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        chat = try container.decodeIfPresent(Int.self, forKey: .chat)
        user = try container.decodeIfPresent(Int.self, forKey: .user)
        isOwner = try container.decodeIfPresent(Bool.self, forKey: .isOwner)
        role = try container.decodeIfPresent(String.self, forKey: .role)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(chat, forKey: .chat)
        try container.encodeIfPresent(user, forKey: .user)
        try container.encodeIfPresent(isOwner, forKey: .isOwner)
        try container.encodeIfPresent(role, forKey: .role)
    }

}
