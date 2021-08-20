//
//  AuthorizationManager.swift
//  
//
//  Created by Алексей Плакош on 30.06.2021.
//

import Foundation
import RestNetwork
import AsapManager
#if canImport(SferaBase)
import SferaBase
#endif

public protocol AuthorizationProtocol {
    func loginUser(info: LoginData, completion: @escaping (Result<SpheraUser, Error>) -> ())
    func registerUser(info: RegisterData, completion: @escaping (Result<SpheraUser, Error>)->())
    func checkAccountToken(accountId: String, completion: @escaping (Result<ResultAuth, Error>) -> ())
    func setNewPassword(info: LoginData, completion: @escaping (Result<SpheraUser, Error>) -> ())
    func obtainToken() -> String?
    func setToken(token: String)
}

public class AuthorizationService {
    static let environment : NetworkEnvironment = .staging
    static var token: String!
    let router = Router<AuthorizationApi>()
    
    public init() {
        
    }
    
    public func handleNetworkResponse(_ response: HTTPURLResponse) -> NetResult<String> {
        switch response.statusCode {
        case 200...299 : return .success
        case 401...500 : return .failure(NetworkResponse.authentificationError.rawValue)
        case 501...599 : return .failure(NetworkResponse.badRequest.rawValue)
        case 600 : return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    public func obtainToken() -> String? {
        return AuthorizationService.token
    }
    
    public func setToken(token: String) {
        AuthorizationService.token = "Bearer " + token
        AsapManager.AsapService.token = "Bearer " + token
    }
}

extension AuthorizationService: AuthorizationProtocol {
	
	private func routerRequest<T: Codable>(_ route: AuthorizationApi,
										   decodeType: T.Type,
										   completion: @escaping (Result<T, Error>) -> Void) {
		router.request(route, completion: { data, response, error in
			if error != nil {
				#if canImport(SferaBase)
				completion(.failure(SError(message: "Connection error")))
				#endif
			}
			if let response = response as? HTTPURLResponse {
				let result = self.handleNetworkResponse(response)
				switch result {
					case .success:
						guard let responseData = data else {
							completion(.failure(NetworkResponse.noData))
							return
						}
						do {
							let apiResponse = try JSONDecoder().decode(decodeType, from: responseData)
							if let spheraUser = apiResponse as? SpheraUser {
								self.setToken(token: spheraUser.token)
							}
							completion(.success(apiResponse))
						} catch {
							completion(.failure(NetworkResponse.ubableToDecode))
						}
						
					case .failure(_):
						completion(.failure(NetworkResponse.failed))
				}
			}
		})
	}
	
    public func loginUser(info: LoginData, completion: @escaping (Result<SpheraUser, Error>) -> ()) {
		routerRequest(.login(info: info),
					  decodeType: SpheraUser.self,
					  completion: completion)
    }
    
    public func registerUser(info: RegisterData, completion: @escaping ((Result<SpheraUser, Error>) -> ())) {
		routerRequest(.register(info: info),
					  decodeType: SpheraUser.self,
					  completion: completion)
    }
    
    public func checkAccountToken(accountId: String, completion: @escaping (Result<ResultAuth, Error>) -> ()) {
		routerRequest(.checkAccountToken(accountId: accountId),
					  decodeType: ResultAuth.self,
					  completion: completion)
    }
    
    public func setNewPassword(info: LoginData, completion: @escaping (Result<SpheraUser, Error>) -> ()) {
		routerRequest(.password(info: info),
					  decodeType: SpheraUser.self,
					  completion: completion)
    }
}

