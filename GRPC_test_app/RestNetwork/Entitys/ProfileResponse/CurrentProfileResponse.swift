//
//  File.swift
//  
//
//  Created by Anton Yaroshchuk on 30.07.2021.
//

import Foundation

public struct CurrentProfileResponse: Codable {
    public var avatar: MediaResource
    public var firstName: String
    public var id: Int
    public var lastName: String
    public var nickName: String
    public var revision: Int
    
    public enum CodingKeys: String, CodingKey {
        case avatar
        case id
        case revision
        case firstName = "First_Name"
        case lastName = "Last_Name"
        case nickName = "Nick_Name"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        avatar = try container.decode(MediaResource.self, forKey: .avatar)
        id = try container.decode(Int.self, forKey: .id)
        revision = try container.decode(Int.self, forKey: .revision)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        nickName = try container.decode(String.self, forKey: .nickName)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(avatar, forKey: .avatar)
        try container.encode(id, forKey: .id)
        try container.encode(revision, forKey: .revision)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(nickName, forKey: .nickName)
    }
}
