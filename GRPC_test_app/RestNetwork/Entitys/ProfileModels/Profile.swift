//
//  File.swift
//  
//
//  Created by Anton Yaroshchuk on 30.07.2021.
//

import Foundation

public struct Profile: Codable {
    public var about: String
    public var accountId: String
    public var avatar: MediaResource
    public var avatarId: Int
    public var createdAt: String
    public var currency: String
    public var deletedAt: String
    public var firstName: String
    public var id: Int
    public var isDream: Bool
    public var isFollow: Bool
    public var language: [String]
    public var lastName: String
    public var lastSeen: String
    public var location: Int
    public var nickName: String
    public var phoneNumber: String
    public var rating: Double
    public var revision: Int
    public var updatedAt: String
    
    public init(about: String,
    accountId: String,
    avatar: MediaResource,
    avatarId: Int,
    createdAt: String,
    currency: String,
    deletedAt: String,
    firstName: String,
    id: Int,
    isDream: Bool,
    isFollow: Bool,
    language: [String],
    lastName: String,
    lastSeen: String,
    location: Int,
    nickName: String,
    phoneNumber: String,
    rating: Double,
    revision: Int,
    updatedAt: String) {
        self.about = about
        self.accountId = accountId
        self.avatar = avatar
        self.avatarId = avatarId
        self.createdAt = createdAt
        self.currency = currency
        self.deletedAt = deletedAt
        self.firstName = firstName
        self.id = id
        self.isDream = isDream
        self.isFollow = isFollow
        self.language = language
        self.lastName = lastName
        self.lastSeen = lastSeen
        self.location = location
        self.nickName = nickName
        self.phoneNumber = phoneNumber
        self.rating = rating
        self.revision = revision
        self.updatedAt = updatedAt
    }
    
    public enum CodingKeys: String, CodingKey {
        case about
        case accountId = "Account_id"
        case avatar
        case avatarId = "Avatar_id"
        case createdAt = "Created_at"
        case currency
        case deletedAt = "Deleted_at"
        case firstName = "First_Name"
        case id
        case isDream = "is_Dream"
        case isFollow = "is_Follow"
        case language
        case lastName = "Last_Name"
        case lastSeen = "Last_Seen"
        case location
        case nickName = "Nick_Name"
        case phoneNumber = "Phone_Number"
        case rating
        case revision
        case updatedAt = "Updated_at"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        about = try container.decode(String.self, forKey: .about)
        accountId = try container.decode(String.self, forKey: .accountId)
        avatar = try container.decode(MediaResource.self, forKey: .avatar)
        avatarId = try container.decode(Int.self, forKey: .avatarId)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        currency = try container.decode(String.self, forKey: .currency)
        deletedAt = try container.decode(String.self, forKey: .deletedAt)
        firstName = try container.decode(String.self, forKey: .firstName)
        id = try container.decode(Int.self, forKey: .id)
        isDream = try container.decode(Bool.self, forKey: .isDream)
        isFollow = try container.decode(Bool.self, forKey: .isFollow)
        language = try container.decode([String].self, forKey: .language)
        lastName = try container.decode(String.self, forKey: .lastName)
        lastSeen = try container.decode(String.self, forKey: .lastSeen)
        location = try container.decode(Int.self, forKey: .location)
        nickName = try container.decode(String.self, forKey: .nickName)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        rating = try container.decode(Double.self, forKey: .rating)
        revision = try container.decode(Int.self, forKey: .revision)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(about, forKey: .about)
        try container.encodeIfPresent(accountId, forKey: .accountId)
        try container.encodeIfPresent(avatar, forKey: .avatar)
        try container.encodeIfPresent(avatarId, forKey: .avatarId)
        try container.encodeIfPresent(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(deletedAt, forKey: .deletedAt)
        try container.encodeIfPresent(firstName, forKey: .firstName)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(isDream, forKey: .isDream)
        try container.encodeIfPresent(isFollow, forKey: .isFollow)
        try container.encodeIfPresent(language, forKey: .language)
        try container.encodeIfPresent(lastName, forKey: .lastName)
        try container.encodeIfPresent(lastSeen, forKey: .lastSeen)
        try container.encodeIfPresent(location, forKey: .location)
        try container.encodeIfPresent(nickName, forKey: .nickName)
        try container.encodeIfPresent(phoneNumber, forKey: .phoneNumber)
        try container.encodeIfPresent(rating, forKey: .rating)
        try container.encodeIfPresent(revision, forKey: .revision)
        try container.encodeIfPresent(updatedAt, forKey: .updatedAt)
    }
}
