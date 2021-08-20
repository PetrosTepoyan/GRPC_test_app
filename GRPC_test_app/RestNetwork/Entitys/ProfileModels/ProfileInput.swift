//
//  File.swift
//  
//
//  Created by Anton Yaroshchuk on 30.07.2021.
//

import Foundation

public struct ProfileInput: Codable {
    public var about: String
    public var currency: String
    public var currentAvatar: Int
    public var firstName: String
    public var isDream: Bool
    public var lastName: String
    public var nickName: String
    
    public init(about: String,
                currency: String,
                currentAvatar: Int,
                firstName: String,
                isDream: Bool,
                lastName: String,
                nickName: String) {
        self.about = about
        self.currency = currency
        self.currentAvatar = currentAvatar
        self.firstName = firstName
        self.isDream = isDream
        self.lastName = lastName
        self.nickName = nickName
    }
    
    public enum CodingKeys: String, CodingKey {
        case about
        case currency
        case currentAvatar = "current_Avatar"
        case firstName = "First_Name"
        case isDream = "Is_Dream"
        case lastName = "Last_Name"
        case nickName = "Nick_Name"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        about = try container.decode(String.self, forKey: .about)
        currency = try container.decode(String.self, forKey: .currency)
        currentAvatar = try container.decode(Int.self, forKey: .currentAvatar)
        firstName = try container.decode(String.self, forKey: .firstName)
        isDream = try container.decode(Bool.self, forKey: .isDream)
        lastName = try container.decode(String.self, forKey: .lastName)
        nickName = try container.decode(String.self, forKey: .nickName)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(about, forKey: .about)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(currentAvatar, forKey: .currentAvatar)
        try container.encodeIfPresent(firstName, forKey: .firstName)
        try container.encodeIfPresent(isDream, forKey: .isDream)
        try container.encodeIfPresent(lastName, forKey: .lastName)
        try container.encodeIfPresent(nickName, forKey: .nickName)
    }
}
