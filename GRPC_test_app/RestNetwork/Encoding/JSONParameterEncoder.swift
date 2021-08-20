//
//  JSONParameterEncoder.swift
//  
//
//  Created by Алексей Плакош on 08.06.2021.
//

import Foundation

public struct BodyParameterEncoder: ParameterBodyEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: BodyParameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: [ .fragmentsAllowed])
            urlRequest.httpBody = jsonAsData
        } catch  {
            throw NetworkError.encodingFailed
        }
    }
}
