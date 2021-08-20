//
//  LoginData.swift
//  
//
//  Created by Алексей Плакош on 30.06.2021.
//

import Foundation

public struct LoginData: Codable {
    public var accountId: String
    public var password: String
    public var deviceBrand: String
    public var deviceManufacture: String
    public var deviceModel: String
    public var deviseOSVersion: String
    public var deviceToken: String
   
    public init(accountId: String,
                password: String,
                deviceBrand: String,
                deviceManufacture: String,
                deviceModel: String,
                deviseOSVersion: String,
                deviceToken: String) {
        
        self.accountId = accountId
        self.password = password
        self.deviceBrand = deviceBrand
        self.deviceManufacture = deviceManufacture
        self.deviceModel = deviceModel
        self.deviseOSVersion = deviseOSVersion
        self.deviceToken = deviceToken
    }
    
    public enum CodingKeys: String, CodingKey {
        case accountId = "accountId"
        case password = "password"
        case deviceBrand = "DeviceBrand"
        case deviceManufacture = "DeviceManufacturer"
        case deviceModel = "DeviceModel"
        case deviseOSVersion = "DeviceOSVersion"
        case deviceToken = "DeviceToken"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accountId = try container.decode(String.self, forKey: .accountId)
        password = try container.decode(String.self, forKey: .password)
        deviceBrand = try container.decode(String.self, forKey: .deviceBrand)
        deviceManufacture = try container.decode(String.self, forKey: .deviceManufacture)
        deviceModel = try container.decode(String.self, forKey: .deviceModel)
        deviseOSVersion = try container.decode(String.self, forKey: .deviseOSVersion)
        deviceToken = try container.decode(String.self, forKey: .deviceToken)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(accountId, forKey: .accountId)
        try container.encode(password, forKey: .password)
        try container.encode(deviceBrand, forKey: .deviceBrand)
        try container.encode(deviceManufacture, forKey: .deviceManufacture)
        try container.encode(deviceModel, forKey: .deviceModel)
        try container.encode(deviseOSVersion, forKey: .deviseOSVersion)
        try container.encode(deviceToken, forKey: .deviceToken)
    }

}
