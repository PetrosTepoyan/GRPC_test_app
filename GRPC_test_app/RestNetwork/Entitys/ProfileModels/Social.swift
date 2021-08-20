//
//  File.swift
//  
//
//  Created by Anton Yaroshchuk on 03.08.2021.
//

import Foundation

public struct Social: Codable {
    public var feedId: Int
    public var forwards: [Int]
    public var likes: [Int]
    
    public init(feedId: Int, forwards: [Int], likes: [Int]) {
        self.feedId = feedId
        self.forwards = forwards
        self.likes = likes
        
    }
    
    public enum CodingKeys: String, CodingKey {
        case feedId = "feed_id"
        case forwards
        case likes
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        feedId = try container.decode(Int.self, forKey: .feedId)
        forwards = try container.decode([Int].self, forKey: .forwards)
        likes = try container.decode([Int].self, forKey: .likes)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(feedId, forKey: .feedId)
        try container.encodeIfPresent(forwards, forKey: .forwards)
        try container.encodeIfPresent(likes, forKey: .likes)
    }
}
