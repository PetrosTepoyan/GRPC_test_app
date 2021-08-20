//
//  File.swift
//
//
//  Created by Алексей Плакош on 13.06.2021.
//

import Foundation

public class Router<EndPoint: EndPointType> : NetworkRouter {
    public var task : URLSessionTask?
    
    public init() {
        
    }
    
    // Основная функция для разборки и отправки запроса на сервер
    public func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: route)
            switch request.httpMethod {
            case HTTPMethod.post.rawValue, HTTPMethod.put.rawValue:
                task = session.uploadTask(with: request, from: request.httpBody, completionHandler: {  data, response, error in
                    completion(data, response, error)
                })
            default:
                task = session.dataTask(with: request, completionHandler: { data, response, error in
                    completion(data, response, error)
                })
            }
        } catch {
            completion(nil, nil, error)
        }
        task?.resume()
    }
    
    // Отмена задачи
    public func cancel() {
        task?.cancel()
    }
    // Построние запроса
    public func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 30.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.httpTask {
            case .request, .download, .upload:
                try self.configureParameters(bodyParameters: route.bodyParametrs, urlParameters: route.urlParameters, request: &request)
                self.configureFields(fields: route.fields, request: &request)
                self.addAditionalHeaders(route.httpHeaders, request: &request)
            }
            #if DEBUG
            print("CURL /n\(request.curlString)")
            #endif
            return request
        } catch  {
            throw error
        }
    }
    
    // Конфигуратор параметров
    public func configureParameters(bodyParameters: BodyParameters?,
                                    urlParameters: URLParameters?,
                                    request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try BodyParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch  {
            throw error
        }
    }
    
    // Конфигуратор полей запроса
    public func configureFields(fields: Fields?, request: inout URLRequest) {
        FieldsEncoder.encode(urlRequest: &request, with: fields)
    }
    
    // Дополнительные заголовки запроса
    public func addAditionalHeaders(_ additionalHeaders: HTTPHeader?, request: inout URLRequest) {
        guard let headers = additionalHeaders else {return}
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}
