//
//  File.swift
//  
//
//  Created by Алексей Плакош on 12.06.2021.
//

import Foundation

public struct Message: Codable {
    public var id  :  String!
    public var from : Int64!
    public var to  : Int64!
    public var recipient: [Int64]!
    public var text: String!
    
    public init(id: String? = nil, from: Int64? = nil, to: Int64? = nil, recipient: [Int64]? = nil, text: String? = nil) {
        self.id = id
        self.from = from
        self.to = to
        self.recipient = recipient
        self.text = text
    }
    
}

public struct Auth: Codable {
    public var token: String!
    
    public init(token: String? = nil) {
        self.token = token
    }
}

public struct Request: Codable {
    public var message : Message!
    
    public init(message: Message? = nil) {
        self.message = message
    }
}
