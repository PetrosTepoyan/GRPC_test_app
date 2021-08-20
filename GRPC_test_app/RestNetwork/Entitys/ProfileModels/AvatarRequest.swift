//
//  File.swift
//  
//
//  Created by Anton Yaroshchuk on 30.07.2021.
//

import Foundation

public struct AvatarRequest: Codable {
    public var orig: String
    public var preview: String
    
    public init(orig: String, preview: String) {
        self.orig = orig
        self.preview = preview
    }
    
    public enum CodingKeys: String, CodingKey {
        case orig
        case preview
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orig = try container.decode(String.self, forKey: .orig)
        preview = try container.decode(String.self, forKey: .preview)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(orig, forKey: .orig)
        try container.encodeIfPresent(preview, forKey: .preview)
    }
}
