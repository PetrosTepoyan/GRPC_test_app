//
//  File.swift
//  
//
//  Created by Anton Yaroshchuk on 30.07.2021.
//

import Foundation

public struct SetProfileRating: Codable {
    public var id: Int
    public var rating: Double
    public var setterId: Int
    
    public init(id: Int, rating: Double, setterId: Int) {
        self.id = id
        self.rating = rating
        self.setterId = setterId
    }
    
    public enum CodingKeys: String, CodingKey {
        case id
        case rating
        case setterId = "Setter_id"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        rating = try container.decode(Double.self, forKey: .rating)
        setterId = try container.decode(Int.self, forKey: .setterId)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(rating, forKey: .rating)
        try container.encodeIfPresent(setterId, forKey: .setterId)
    }
}
