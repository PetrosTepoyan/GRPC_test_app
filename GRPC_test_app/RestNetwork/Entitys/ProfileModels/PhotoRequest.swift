//
//  File.swift
//  
//
//  Created by Anton Yaroshchuk on 30.07.2021.
//

import Foundation

public struct PhotoRequest: Codable {
    public var orig: String
    
    public init(orig: String) {
        self.orig = orig
    }
    
    public enum CodingKeys: String, CodingKey {
        case orig
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orig = try container.decode(String.self, forKey: .orig)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(orig, forKey: .orig)
    }}
