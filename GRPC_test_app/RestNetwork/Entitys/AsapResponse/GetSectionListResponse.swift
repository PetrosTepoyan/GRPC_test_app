//
//  GetSectionListResponse.swift
//  
//
//  Created by Алексей Плакош on 18.07.2021.
//

import Foundation

public struct GetSectionListResponse: Codable {
    public var count: Int
    public var next: String!
    public var previous: String!
    public var results: [Section]
    
    public enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        next = try container.decodeIfPresent(String.self, forKey: .next)
        previous = try container.decodeIfPresent(String.self, forKey: .previous)
        results = try container.decode([Section].self, forKey: .results)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try container.encodeIfPresent(next, forKey: .next)
        try container.encodeIfPresent(previous, forKey: .previous)
        try container.encode(results, forKey: .results)
    }
}
