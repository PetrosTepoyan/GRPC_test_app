//
//  File.swift
//  
//
//  Created by Anton Yaroshchuk on 30.07.2021.
//

import Foundation

public struct AllProfileInfo: Codable {
    public var deviceBrand: String
    public var profileId: Int
    
    public init(profileId: Int, deviceBrand: String) {
        self.profileId = profileId
        self.deviceBrand = deviceBrand
        
    }
    
    public enum CodingKeys: String, CodingKey {
        case deviceBrand = "DeviceBrand"
        case profileId = "profile_id"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        profileId = try container.decode(Int.self, forKey: .profileId)
        deviceBrand = try container.decode(String.self, forKey: .deviceBrand)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(profileId, forKey: .profileId)
        try container.encodeIfPresent(deviceBrand, forKey: .deviceBrand)
    }
}
