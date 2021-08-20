//
//  File.swift
//  
//
//  Created by Алексей Плакош on 13.06.2021.
//

import Foundation

public enum NetworkResponse: String, Error {
    case success
    case authentificationError = "Ошибка авторизации"
    case badRequest = "Плохой запрос"
    case outdated = "Ссылка устарела"
    case failed = "Ошибка"
    case noData = "Нет данных"
    case ubableToDecode = "Невозможно декодировать"
}

