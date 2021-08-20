//
//  File.swift
//  
//
//  Created by Алексей Плакош on 13.06.2021.
//

import Foundation

public protocol NetworkRouter {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
