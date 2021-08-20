//
//  File.swift
//  
//
//  Created by Алексей Плакош on 11.07.2021.
//

import Foundation

// Протокол кодирует параметры
public protocol FieldsEncoderProtocol {
    /// Кодиреует параметры для запроса
    static func encode(urlRequest: inout URLRequest, with parameters: Fields?) 
}
