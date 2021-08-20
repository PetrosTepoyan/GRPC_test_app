//
//  File.swift
//  
//
//  Created by Алексей Плакош on 27.07.2021.
//

import Foundation

public struct ProfileGetAllResponse: Codable {
    public var profileIds: [Int]
    
    public enum CodingKeys: String, CodingKey {
        case profileIds
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        profileIds = try container.decode([Int].self, forKey: .profileIds)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(profileIds, forKey: .profileIds)
    }
}
