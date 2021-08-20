//
//  File.swift
//  
//
//  Created by Dzmitry Semenovich on 16.08.21.
//

import Foundation

public struct PasswordData: Codable {
    public var accountId: String
    public var deviceBrand: String
    public var deviceManufacture: String
    public var deviceModel: String
    public var deviseOSVersion: String
    public var deviceToken: String
    public var newPassword: String
    public var oldPassword: String
    
    public init(accountId: String,
                deviceBrand: String,
                deviceManufacture: String,
                deviceModel: String,
                deviseOSVersion: String,
                deviceToken: String,
                newPassword: String,
                oldPassword: String) {
        
        self.accountId = accountId
        self.deviceBrand = deviceBrand
        self.deviceManufacture = deviceManufacture
        self.deviceModel = deviceModel
        self.deviseOSVersion = deviseOSVersion
        self.deviceToken = deviceToken
        self.newPassword = newPassword
        self.oldPassword = oldPassword
    }
    
    public enum CodingKeys: String, CodingKey {
        case accountId = "accountId"
        case deviceBrand = "deviceBrand"
        case deviceManufacture = "deviceManufacturer"
        case deviceModel = "deviceModel"
        case deviseOSVersion = "deviceOSVersion"
        case deviceToken = "deviceToken"
        case newPassword = "newPassword"
        case oldPassword = "oldPassword"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accountId = try container.decode(String.self, forKey: .accountId)
        deviceBrand = try container.decode(String.self, forKey: .deviceBrand)
        deviceManufacture = try container.decode(String.self, forKey: .deviceManufacture)
        deviceModel = try container.decode(String.self, forKey: .deviceModel)
        deviseOSVersion = try container.decode(String.self, forKey: .deviseOSVersion)
        deviceToken = try container.decode(String.self, forKey: .deviceToken)
        newPassword = try container.decode(String.self, forKey: .newPassword)
        oldPassword = try container.decode(String.self, forKey: .oldPassword)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(accountId, forKey: .accountId)
        try container.encode(deviceBrand, forKey: .deviceBrand)
        try container.encode(deviceManufacture, forKey: .deviceManufacture)
        try container.encode(deviceModel, forKey: .deviceModel)
        try container.encode(deviseOSVersion, forKey: .deviseOSVersion)
        try container.encode(deviceToken, forKey: .deviceToken)
        try container.encode(newPassword, forKey: .newPassword)
        try container.encode(oldPassword, forKey: .oldPassword)
    }
}
