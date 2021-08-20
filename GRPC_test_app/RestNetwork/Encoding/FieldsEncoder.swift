//
//  File.swift
//  
//
//  Created by Алексей Плакош on 11.07.2021.
//

import Foundation


public struct FieldsEncoder: FieldsEncoderProtocol {
    public static func encode(urlRequest: inout URLRequest, with parameters: Fields?) {
        guard let fields = parameters else {return}
        for field in fields {
            if urlRequest.value(forHTTPHeaderField: field.key) == nil {
                urlRequest.setValue(field.value, forHTTPHeaderField: field.key)
            }
        }
    }
}
