//
//  File.swift
//  
//
//  Created by Anton Yaroshchuk on 31.07.2021.
//

import Foundation

public struct StatusResponse: Codable {
    public var status: String
    
    public enum CodingKeys: String, CodingKey {
        case status
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String.self, forKey: .status)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(status, forKey: .status)
    }
}
