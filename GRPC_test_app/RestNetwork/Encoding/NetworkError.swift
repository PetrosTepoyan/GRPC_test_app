//
//  File.swift
//  
//
//  Created by Алексей Плакош on 13.06.2021.
//

import Foundation

public enum NetworkError: String, Error {
    case parametersNil = "Нет параметров бро"
    case encodingFailed = "Кодирование провалилось"
    case missingUrl = "Ты забыл УРЛ, как так?"
}
