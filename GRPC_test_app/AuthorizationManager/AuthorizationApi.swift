//
//  AsapApi.swift
//  
//
//  Created by Алексей Плакош on 13.06.2021.
//

import Foundation
import RestNetwork

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

// Энд поинт для АСАП
public enum AuthorizationApi {
    // Chat
    case login(info: LoginData) // post
    case register(info: RegisterData) // post
    case checkAccountToken(accountId: String) // get
    case password(info: LoginData) // put
}

// Экстеншен для формирования эндпоинта АСАП
extension AuthorizationApi : EndPointType {
    
    var environmentBaseURL : String {
         switch AuthorizationService.environment { //https://core.stage.sfera-app.ru/api/login
         case .production: return "http://core.stage.sfera-app.ru/api"
         case .qa: return "http://core.stage.sfera-app.ru/api"
         case .staging: return "http://core.stage.sfera-app.ru/api"
         }
     }
    
    public var baseUrl: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
                return url
    }
    
    public var path: String {
        switch self {
        case .login:
            return "/login/"
        case .register:
            return "/registration/"
        case .checkAccountToken:
            return "/checkAccountToken/"
        case .password:
            return "/password/"
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .login, .register:
            return .post
        case .password:
            return .put
        case .checkAccountToken:
            return .get
        }
    }
    
    public var httpTask: HTTPTask {
        switch self {
        case .login, .register, .password, .checkAccountToken:
            return .request
        }
    }
    
    public var bodyParametrs: BodyParameters? {
        switch self {
        case .login(info: let info):
            do {
                let dictionary = try DictionaryEncoder().encode(info)
                return dictionary
            } catch  {
                return nil
            }
        case .register(info: let info):
            do {
                let dictionary = try DictionaryEncoder().encode(info)
                return dictionary
            } catch  {
                return nil
            }
        case .password(info: let info):
            do {
                let dictionary = try DictionaryEncoder().encode(info)
                return dictionary
            } catch  {
                return nil
            }
        case .checkAccountToken:
            return nil
        }
    }
    
    public var urlParameters: URLParameters? {
        switch self {
        case .login, .register, .password:
            return nil
        case .checkAccountToken(accountId: let accountId):
            return ["accountId": accountId]
        }
    }
    
    public var fields: Fields? {
        switch self {
        case .login:
            return nil
        case .password:
            return ["accept":"application/json",
                    "Content-Type":"application/json"]
        case .register, .checkAccountToken:
            return ["Content-Type": "application/json"]
        }
    }
    
    public var httpHeaders: HTTPHeader? {
        switch self {
        case .checkAccountToken, .password:
            return ["Authorization" : AuthorizationService.token ?? ""]
        default:
            return nil
            
        }
    }
}

