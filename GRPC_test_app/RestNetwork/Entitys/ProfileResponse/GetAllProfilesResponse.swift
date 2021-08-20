//
//  File.swift
//  
//
//  Created by Anton Yaroshchuk on 03.08.2021.
//

import Foundation

public struct GetAllProfilesResponse: Codable {
    public var profiles: [Profile]
    public var limit: Int
    public var offset: Int
    public var total: Int
    
    public enum CodingKeys: String, CodingKey {
        case profiles
        case limit
        case offset
        case total
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        profiles = try container.decode([Profile].self, forKey: .profiles)
        limit = try container.decode(Int.self, forKey: .limit)
        offset = try container.decode(Int.self, forKey: .offset)
        total = try container.decode(Int.self, forKey: .total)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(profiles, forKey: .profiles)
        try container.encode(limit, forKey: .limit)
        try container.encode(offset, forKey: .offset)
        try container.encode(total, forKey: .total)
    }
}
