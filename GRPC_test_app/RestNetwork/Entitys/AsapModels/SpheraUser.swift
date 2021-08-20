//
//  SpheraUser.swift
//  
//
//  Created by Алексей Плакош on 30.06.2021.
//

import Foundation

/*
 {
   "id": 121138692,
   "accountId": "121138692",
   "nickName": "asdsadasdas",
   "currentProfile": {
     "id": 121138692,
     "nickName": "asdsadasdas",
     "firstName": "",
     "lastName": "",
     "avatar": null,
     "revision": 0
   },
   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6MTIxMTM4NjkyfQ.D-OAXoT9FQJBbPs7dALRiSGJAxw53O3SpvXz6kkwEAg"
 }
 */

public struct SpheraUser: Codable {
    public var id: Int64
    public var accountId: String
    public var nickName: String
    public var currentProfile: CurrentProfile
    public var token: String
    
    public struct CurrentProfile: Codable {
        public var id: Int64
        public var nickName: String
        public var firstName: String
        public var lastName: String
        //public var avatar: String?
        public var revision: Int
        
        public enum CodingKeys: String, CodingKey {
            case id = "id"
            case nickName = "nickName"
            case firstName = "firstName"
            case lastName = "lastName"
            //case avatar = "avatar"
            case revision = "revision"
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int64.self, forKey: .id)
            nickName = try container.decode(String.self, forKey: .nickName)
            firstName = try container.decode(String.self, forKey: .nickName)
            lastName = try container.decode(String.self, forKey: .lastName)
            //avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
            revision = try container.decode(Int.self, forKey: .revision)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(nickName, forKey: .nickName)
            try container.encode(firstName, forKey: .firstName)
            try container.encode(lastName, forKey: .lastName)
            //try container.encodeIfPresent(avatar, forKey: .avatar)
            try container.encode(revision, forKey: .revision)
        }
    }
    
    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case accountId = "accountId"
        case nickName = "nickName"
        case currentProfile = "currentProfile"
        case token = "token"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int64.self, forKey: .id)
        accountId = try container.decode(String.self, forKey: .accountId)
        nickName = try container.decode(String.self, forKey: .nickName)
        currentProfile = try container.decode(CurrentProfile.self, forKey: .currentProfile)
        token = try container.decode(String.self, forKey: .token)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(accountId, forKey: .accountId)
        try container.encode(nickName, forKey: .nickName)
        try container.encode(currentProfile, forKey: .currentProfile)
        try container.encode(token, forKey: .token)
    }

}

