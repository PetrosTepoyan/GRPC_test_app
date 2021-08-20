//
//  File.swift
//  
//
//  Created by Anton Yaroshchuk on 31.07.2021.
//

import Foundation

public struct GetAllAvatarsResponse: Codable {
    public var mediaResources: [MediaResource]
    public var limit: Int
    public var offset: Int
    public var total: Int
    
    public enum CodingKeys: String, CodingKey {
        case mediaResources
        case limit
        case offset
        case total
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mediaResources = try container.decode([MediaResource].self, forKey: .mediaResources)
        limit = try container.decode(Int.self, forKey: .limit)
        offset = try container.decode(Int.self, forKey: .offset)
        total = try container.decode(Int.self, forKey: .total)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(mediaResources, forKey: .mediaResources)
        try container.encode(limit, forKey: .limit)
        try container.encode(offset, forKey: .offset)
        try container.encode(total, forKey: .total)
    }
}
