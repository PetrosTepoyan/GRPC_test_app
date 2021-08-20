//
//  File.swift
//  
//
//  Created by Anton Yaroshchuk on 30.07.2021.
//

import Foundation

public struct FollowersByProfileIdResponse: Codable {
    public var profileIds: [Int]
    public var profileId: Int
    
    public enum CodingKeys: String, CodingKey {
        case profileIds = "Profile_ids"
        case profileId = "Profile_id"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        profileIds = try container.decode([Int].self, forKey: .profileIds)
        profileId = try container.decode(Int.self, forKey: .profileId)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(profileIds, forKey: .profileIds)
        try container.encode(profileId, forKey: .profileId)
    }
}
