//
//  EndPointType.swift
//  
//
//  Created by Алексей Плакош on 13.06.2021.
//

import Foundation

public protocol EndPointType {
    var baseUrl : URL {get}
    var path : String {get}
    var httpMethod: HTTPMethod {get}
    var bodyParametrs: BodyParameters? {get}
    var urlParameters: URLParameters? {get}
    var fields: Fields? {get}
    var httpTask: HTTPTask {get}
    var httpHeaders: HTTPHeader? {get}
}
