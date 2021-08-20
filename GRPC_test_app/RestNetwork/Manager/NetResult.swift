//
//  File.swift
//  
//
//  Created by Алексей Плакош on 13.06.2021.
//

import Foundation

public enum NetResult<Error> {
    case success
    case failure(Error)
}

