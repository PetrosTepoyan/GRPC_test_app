//
//  File.swift
//  
//
//  Created by Алексей Плакош on 13.06.2021.
//

import Foundation

// Протокол кодирует параметры
public protocol ParameterUrlEncoder {
    /// Кодиреует параметры для запроса
    static func encode(urlRequest: inout URLRequest, with parameters: URLParameters) throws
}

// Протокол кодирует параметры так как вам нужно
public protocol ParameterBodyEncoder {
    /// Кодирует параметры для запроса
    static func encode(urlRequest: inout URLRequest, with parameters: BodyParameters) throws
}
