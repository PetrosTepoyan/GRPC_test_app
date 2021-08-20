//
//  AuthorizationManager.swift
//  
//
//  Created by Алексей Плакош on 30.06.2021.
//

import Foundation
import RestNetwork

public protocol ProfileProtocol {
    func obtainToken() -> String?
    func getAllProfiles(data: ProfileGetAll, completion: @escaping (Result<ProfileGetAllResponse, Error>) -> Void)
    func syncContacts(completion: @escaping (Result<[Profile], Error>) -> Void)
    func getCurrentProfile(completion: @escaping (Result<Profile, Error>) -> Void)
    func createProfile(data: ProfileInput, completion: @escaping (Result<ProfileInput, Error>) -> Void)
    func getProfileById(id: Int, completion: @escaping (Result<Profile, Error>) -> Void)
    func updateProfile(id: Int, data: ProfileInput, completion: @escaping (Result<StatusResponse, Error>) -> Void)
    func getAvatarsByProfileId(id: Int, limit: Int, offset: Int, completion: @escaping (Result<[GetAllAvatarsResponse], Error>) -> Void)
    func createAvatarByProfileId(id: Int, data: AvatarRequest, completion: @escaping (Result<ObjectIdResponse, Error>) -> Void)
    func deleteAvatarByProfileId(id: Int, avatarId: Int, completion: @escaping (Result<StatusResponse, Error>) -> Void)
    func followersToByProfileId(id: Int, limit: Int, offset: Int, completion: @escaping (Result<[GetAllProfilesResponse], Error>) -> Void)
    func followingByProfileId(id: Int, limit: Int, offset: Int, completion: @escaping (Result<[GetAllProfilesResponse], Error>) -> Void)
    func followByProfileId(id: Int, followId: Int, completion: @escaping (Result<StatusResponse, Error>) -> Void)
    func unfollowByProfileId(id: Int, completion: @escaping (Result<String, Error>) -> Void)
    func loversByProfileId(id: Int, limit: Int, offset: Int, completion: @escaping (Result<[GetAllProfilesResponse], Error>) -> Void)
    func setProfileLanguage(language: SetProfileLanguage, completion: @escaping (Result<StatusResponse, Error>) -> Void)
    func setProfileLocation(location: SetProfileLocation, completion: @escaping (Result<StatusResponse, Error>) -> Void)
    func setProfileRating(rating: SetProfileRating, completion: @escaping (Result<StatusResponse, Error>) -> Void)
    func getPhotosByProfileId(id: Int, limit: Int, offset: Int, completion: @escaping (Result<[GetAllAvatarsResponse], Error>) -> Void)
    func uploadAvatarByProfileId(id: Int, data: AvatarRequest, completion: @escaping (Result<ObjectIdResponse, Error>) -> Void)
    func updatePhotoByProfileId(id: Int, completion: @escaping (Result<ObjectIdResponse, Error>) -> Void)
    func uploadPhotoByProfileId(id: Int, uploadData: PhotoRequest, completion: @escaping (Result<ObjectIdResponse, Error>) -> Void)
    func deletePhotoByProfileId(id: Int, photoId: Int, completion: @escaping (Result<String, Error>) -> Void) //Нет параметров ответа в swagger?
    func setCurrentAvatarByPhotoId(id: Int, photoId: Int, completion: @escaping (Result<ObjectIdResponse, Error>) -> Void)
    func setCurrentAvatar(id: Int, avatarId: Int, completion: @escaping (Result<String, Error>) -> Void)
    func getOldAvatarsByProfileId(id: Int, completion: @escaping (Result<[MediaResource], Error>) -> Void)
    func getCurrentAvatar(id: Int, completion: @escaping (Result<MediaResource, Error>) -> Void)
    func oldUpdateProfileById(data: ProfileInput, completion: @escaping (Result<ProfileInput, Error>) -> Void)
    func oldGetProfileById(id: Int, completion: @escaping (Result<Profile, Error>) -> Void)
    func getProfiles(completion: @escaping (Result<[Profile], Error>) -> Void)
    func getAvatarById(avatarId: Int, completion: @escaping (Result<[MediaResource], Error>) -> Void)
    func getProfilesByIds(ids: Int, completion: @escaping (Result<[Profile], Error>) -> Void)
    func searchProfiles(query: String, completion: @escaping (Result<[Profile], Error>) -> Void)
    func searchProfilesById(id: Int, completion: @escaping (Result<[Profile], Error>) -> Void)
}

public class ProfileService {
    static let environment : NetworkEnvironment = .staging
    let router = Router<ProfileApi>()
    var token: String!
    
    public init() {
        
    }
    
    public func handleNetworkResponse(_ response: HTTPURLResponse) -> NetResult<Error> {
         switch response.statusCode {
         case 200...299 : return .success
         case 401...500 : return .failure(NetworkResponse.authentificationError)
         case 501...599 : return .failure(NetworkResponse.badRequest)
         case 600 : return .failure(NetworkResponse.outdated)
         default: return .failure(NetworkResponse.failed)
         }
     }
    
    public func obtainToken() -> String? {
        return token
    }
}

extension ProfileService: ProfileProtocol {
    /// Получить список профайлов
    /// - Parameter ProfileGetAll: экземпляр структуры запроса профайлов
   public func getAllProfiles(data: ProfileGetAll, completion: @escaping (Result<ProfileGetAllResponse, Error>) -> Void) {
        router.request(.getAllProfiles(data: data), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(ProfileGetAllResponse.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Синхронизация контактов
    public func syncContacts(completion: @escaping (Result<[Profile], Error>) -> Void) {
        router.request(.syncContacts, completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode([Profile].self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    ///Получение данных активного аккаунта
    public func getCurrentProfile(completion: @escaping (Result<Profile, Error>) -> Void) {
        router.request(.getCurrentProfile, completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(Profile.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Создание профиля
    /// - Parameter data: экземпляр структуры ProfileInput для создания профиля
    public func createProfile(data: ProfileInput, completion: @escaping (Result<ProfileInput, Error>) -> Void) {
        router.request(.createProfile(data: data), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(ProfileInput.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Получения профиля по идентификатору
    /// - Parameter id: идентификатор профиля
    public func getProfileById(id: Int, completion: @escaping (Result<Profile, Error>) -> Void) {
        router.request(.getProfileById(id: id), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(Profile.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Обновление профиля
    /// - Parameter id: идентификатор профиля
    /// - Parameter data: экземпляр структуры ProfileInput для обновления
    public func updateProfile(id: Int, data: ProfileInput, completion: @escaping (Result<StatusResponse, Error>) -> Void) {
        router.request(.updateProfile(id: id, data: data), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(StatusResponse.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Получение аватаров по идентификатору профиля
    /// - Parameter id: идентификатор профиля
    /// - Parameter limit: Количество выведеных результатов
    /// - Parameter offset: Смещение
    public func getAvatarsByProfileId(id: Int, limit: Int, offset: Int, completion: @escaping (Result<[GetAllAvatarsResponse], Error>) -> Void) {
        router.request(.getAvatarsByProfileId(id: id, limit: limit, offset: offset), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode([GetAllAvatarsResponse].self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Создание аватара профиля
    /// - Parameter id: идентификатор профиля
    /// - Parameter data: экземпляр структуры AvatarRequest  для создания аватара профиля
    public func createAvatarByProfileId(id: Int, data: AvatarRequest, completion: @escaping (Result<ObjectIdResponse, Error>) -> Void) {
        router.request(.createAvatarByProfileId(id: id, data: data), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(ObjectIdResponse.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Удаление аватара по идентификатору профиля
    /// - Parameter id: идентификатор профиля
    /// - Parameter avatarId: идентификатор аватара
    public func deleteAvatarByProfileId(id: Int, avatarId: Int, completion: @escaping (Result<StatusResponse, Error>) -> Void) {
        router.request(.deleteAvatarByProfileId(id: id, avatarId: avatarId), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(StatusResponse.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Получение всех профайлов подписавшихся на профиль
    /// - Parameter id: идентификатор профиля
    /// - Parameter limit: Количество выведеных результатов
    /// - Parameter offset: Смещение
    public func followersToByProfileId(id: Int, limit: Int, offset: Int, completion: @escaping (Result<[GetAllProfilesResponse], Error>) -> Void) {
        router.request(.followersToByProfileId(id: id, limit: limit, offset: offset), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode([GetAllProfilesResponse].self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Перечень профилей, на которые подписан владелец идентификатора профиля
    /// - Parameter id: идентификатор профиля
    /// - Parameter limit: Количество выведеных результатов
    /// - Parameter offset: Смещение
    public func followingByProfileId(id: Int, limit: Int, offset: Int, completion: @escaping (Result<[GetAllProfilesResponse], Error>) -> Void) {
        router.request(.followingByProfileId(id: id, limit: limit, offset: offset), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode([GetAllProfilesResponse].self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Подписка на профиль по идентификатору
    /// - Parameter id: идентификатор профиля
    /// - Parameter followId: идентификатор профиля для подписки
    public func followByProfileId(id: Int, followId: Int, completion: @escaping (Result<StatusResponse, Error>) -> Void) {
        router.request(.followByProfileId(id: id, followId: followId), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(StatusResponse.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Отмена подписки по идентификатору профиля
    /// - Parameter id: идентификатор профиля для отмены подписки
    public func unfollowByProfileId(id: Int, completion: @escaping (Result<String, Error>) -> Void) {
        router.request(.unfollowByProfileId(id: id), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(String.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// <3 <3 <3 Лайки <3 <3 <3 по идентификатору профиля?
    /// - Parameter id: идентификатор профиля
    /// - Parameter limit: Количество выведеных результатов
    /// - Parameter offset: Смещение
    public func loversByProfileId(id: Int, limit: Int, offset: Int, completion: @escaping (Result<[GetAllProfilesResponse], Error>) -> Void) {
        router.request(.loversByProfileId(id: id, limit: limit, offset: offset), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode([GetAllProfilesResponse].self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Установить язык профиля
    /// - Parameter language: экземпляр структуры SetProfileLanguage для выбранного языка профиля
    public func setProfileLanguage(language: SetProfileLanguage, completion: @escaping (Result<StatusResponse, Error>) -> Void) {
        router.request(.setProfileLanguage(language: language), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(StatusResponse.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Установить местоположение профиля
    /// - Parameter location: экземпляр структуры SetProfileLocation для выбора местоположения
    public func setProfileLocation(location: SetProfileLocation, completion: @escaping (Result<StatusResponse, Error>) -> Void) {
        router.request(.setProfileLocation(location: location), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(StatusResponse.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Установить рейтинг профиля
    /// - Parameter rating: экземпляр структуры SetProfileRating для изменения рейтинга
    public func setProfileRating(rating: SetProfileRating, completion: @escaping (Result<StatusResponse, Error>) -> Void) {
        router.request(.setProfileRating(rating: rating), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(StatusResponse.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Получить фотографии по идентификатору профиля
    /// - Parameter id: идентификатор профиля
    /// - Parameter limit: Количество выведеных результатов
    /// - Parameter offset: Смещение
    public func getPhotosByProfileId(id: Int, limit: Int, offset: Int, completion: @escaping (Result<[GetAllAvatarsResponse], Error>) -> Void) {
        router.request(.getPhotosByProfileId(id: id, limit: limit, offset: offset), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode([GetAllAvatarsResponse].self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Загрузка аватара профиля по идентификатору
    /// - Parameter id: идентификатор профиля
    /// - Parameter data: экземпляр структуры AvatarRequest
    public func uploadAvatarByProfileId(id: Int, data: AvatarRequest, completion: @escaping (Result<ObjectIdResponse, Error>) -> Void) {
        router.request(.uploadAvatarByProfileId(id: id, data: data), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(ObjectIdResponse.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Обновить фотографию по идентификатору профиля
    /// - Parameter id: идентификатор профиля
    public func updatePhotoByProfileId(id: Int, completion: @escaping (Result<ObjectIdResponse, Error>) -> Void) {
        router.request(.updatePhotoByProfileId(id: id), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(ObjectIdResponse.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Загрузить фотографию по идентификатору профиля
    /// - Parameter id: идентификатор профиля
    /// - Parameter uploadData: экземпляр структуры PhotoRequest
    public func uploadPhotoByProfileId(id: Int, uploadData: PhotoRequest, completion: @escaping (Result<ObjectIdResponse, Error>) -> Void) {
        router.request(.uploadPhotoByProfileId(id: id, uploadData: uploadData), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(ObjectIdResponse.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Удаление фотографии по идентификатору
    /// - Parameter id: идентификатор профиля
    /// - Parameter photoId: идентификатор фотографии для удаления
    public func deletePhotoByProfileId(id: Int, photoId: Int, completion: @escaping (Result<String, Error>) -> Void) {
        router.request(.deletePhotoByProfileId(id: id, photoId: photoId), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(String.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Установка аватара по идентификаторам профиля и фотографии
    /// - Parameter id: идентификатор профиля
    /// - Parameter photoId: идентификатор фотографии
    public func setCurrentAvatarByPhotoId(id: Int, photoId: Int, completion: @escaping (Result<ObjectIdResponse, Error>) -> Void) {
        router.request(.setCurrentAvatarByPhotoId(id: id, photoId: photoId), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(ObjectIdResponse.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Установка аватара по идентификатору
    /// - Parameter id: идентификатор профиля
    /// - Parameter avatarId: идентификатор аватара
    public func setCurrentAvatar(id: Int, avatarId: Int, completion: @escaping (Result<String, Error>) -> Void) {
        router.request(.setCurrentAvatar(id: id, avatarId: avatarId), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(String.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Получить перечень аватаров по идентификатору профиля
    /// - Parameter id: идентификатор профиля
    public func getOldAvatarsByProfileId(id: Int, completion: @escaping (Result<[MediaResource], Error>) -> Void) {
        router.request(.getOldAvatarsByProfileId(id: id), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode([MediaResource].self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    ///Получение данные текущего аватара
    /// - Parameter id: идентификатор профиля
    public func getCurrentAvatar(id: Int, completion: @escaping (Result<MediaResource, Error>) -> Void) {
        router.request(.getCurrentAvatar(id: id), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(MediaResource.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Обновление профиля
    /// - Parameter data: экземпляр структуры ProfileInput
    public func oldUpdateProfileById(data: ProfileInput, completion: @escaping (Result<ProfileInput, Error>) -> Void) {
        router.request(.oldUpdateProfileById(data: data), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(ProfileInput.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Получение данных профиля по идентификатору
    /// - Parameter id: идентификатор профиля
    public func oldGetProfileById(id: Int, completion: @escaping (Result<Profile, Error>) -> Void) {
        router.request(.oldGetProfileById(id: id), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode(Profile.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    ///Получение данных профилей
    public func getProfiles(completion: @escaping (Result<[Profile], Error>) -> Void) {
        router.request(.getProfiles, completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode([Profile].self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Получение аватара по идентификатору
    /// - Parameter avatarId: идентификатор профиля
    public func getAvatarById(avatarId: Int, completion: @escaping (Result<[MediaResource], Error>) -> Void) {
        router.request(.getAvatarById(avatarId: avatarId), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode([MediaResource].self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Получение профилей по идентификаторам
    /// - Parameter ids: идентификаторы профилей?
    public func getProfilesByIds(ids: Int, completion: @escaping (Result<[Profile], Error>) -> Void) {
        router.request(.getProfilesByIds(ids: ids), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode([Profile].self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Поиск профиля
    /// - Parameter query: строка(String) запроса для поиска
    public func searchProfiles(query: String, completion: @escaping (Result<[Profile], Error>) -> Void) {
        router.request(.searchProfiles(query: query), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode([Profile].self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    /// Поиск профиля по идентификатору
    /// - Parameter id: идентификатор профиля
    public func searchProfilesById(id: Int, completion: @escaping (Result<[Profile], Error>) -> Void) {
        router.request(.searchProfilesById(id: id), completion: { data, response, error in
            if error != nil {
                completion(.failure(error!))
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
                        let apiResponse = try JSONDecoder().decode([Profile].self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.ubableToDecode))
                    }

                case .failure(let failureError):
                    completion(.failure(failureError))
                }
            }
        })
    }
    
    
}
