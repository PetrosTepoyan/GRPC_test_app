//
//  URLParameterEncoder.swift
//  
//
//  Created by Алексей Плакош on 08.06.2021.
//

import Foundation

public struct URLParameterEncoder: ParameterUrlEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: URLParameters) throws {
        
        guard let url = urlRequest.url else {throw NetworkError.missingUrl}
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
    }
}
