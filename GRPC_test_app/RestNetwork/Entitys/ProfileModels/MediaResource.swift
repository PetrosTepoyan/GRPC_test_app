//
//  File.swift
//  
//
//  Created by Anton Yaroshchuk on 30.07.2021.
//

import Foundation

public struct MediaResource: Codable {
    public var clientMessageId: Int
    public var content: [Avatar]
    public var id: Int
    public var profileId: Int
    public var resourceType: Int
    public var social: Social
    
    public init(clientMessageId: Int,
                content: [Avatar],
                id: Int,
                profileId: Int,
                resourceType: Int,
                social: Social) {
        self.clientMessageId = clientMessageId
        self.content = content
        self.id = id
        self.profileId = profileId
        self.resourceType = resourceType
        self.social = social
        
    }
    
    public enum CodingKeys: String, CodingKey {
        case clientMessageId = "client_Message_Id"
        case content
        case id
        case profileId = "profile_id"
        case resourceType = "resource_Type"
        case social
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        clientMessageId = try container.decode(Int.self, forKey: .clientMessageId)
        content = try container.decode([Avatar].self, forKey: .content)
        id = try container.decode(Int.self, forKey: .id)
        profileId = try container.decode(Int.self, forKey: .profileId)
        resourceType = try container.decode(Int.self, forKey: .resourceType)
        social = try container.decode(Social.self, forKey: .social)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(clientMessageId, forKey: .clientMessageId)
        try container.encodeIfPresent(content, forKey: .content)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(profileId, forKey: .profileId)
        try container.encodeIfPresent(resourceType, forKey: .resourceType)
        try container.encodeIfPresent(social, forKey: .social)
    }
}
