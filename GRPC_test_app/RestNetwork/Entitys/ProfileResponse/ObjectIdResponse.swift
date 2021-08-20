//
//  File.swift
//  
//
//  Created by Anton Yaroshchuk on 31.07.2021.
//

import Foundation

public struct ObjectIdResponse: Codable {
    public var id: Int
    
    public enum CodingKeys: String, CodingKey {
        case id
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
    }
}
