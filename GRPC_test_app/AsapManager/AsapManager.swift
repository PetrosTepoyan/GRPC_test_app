//
//  AsapManager.swift
//
//
//  Created by Алексей Плакош on 13.06.2021.
//

import Foundation
import RestNetwork

public protocol AsapServiceProtocol {
    // Функционал asap
    func chatGetList(isActive: Bool, limit: Int, offset: Int, completion: @escaping (Result<GetChatListResponse, Error>) -> Void)
    func chatCreate(chat: Chat, completion: @escaping (Result<Chat, Error>) -> Void)
    func chatToAchive(id: Int, completion: @escaping (Result<Chat, Error>) -> Void)
    func chatGetAppPermissions(completion: @escaping (Result<[PermissionAction], Error>) -> Void)
    func chatMemberCreate(member: Member, completion: @escaping (Result<Member, Error>) -> Void)
    func chatMemberUpdate(chatId: Int, userId: Int, member: Member, completion: @escaping (Result<MemberUpdate, Error>) -> Void)
    func chatMemberDelete(chatId: Int, userId: Int, completion: @escaping (Result<String, Error>) -> Void)
    func chatRead(id: Int, completion: @escaping (Result<Chat, Error>) -> Void)
    func chatUpdate(id: Int, chat: Chat, completion: @escaping (Result<Chat, Error>) -> Void)
    func chatDelete(id: Int, completion: @escaping (Result<String, Error>) -> Void)
        // Функционал contact
    func contactsGetList(limit: Int, offset: Int, completion: @escaping (Result<GetContactsListResponse, Error>) -> Void)
    func contactCreate(contact: Contact, completion: @escaping (Result<Contact, Error>) -> Void)
    func contactRead(id: Int, completion: @escaping (Result<Contact, Error>) -> Void)
    func contactUpdate(contact: Contact, id: Int, completion: @escaping (Result<Contact, Error>) -> Void)
    func contactDelete(id: Int, completion: @escaping (Result<String, Error>) -> Void)
    func contactsOwnerGetList(ownerProfileId: Int, limit: Int, offset: Int, completion: @escaping (Result<GetContactsListResponse, Error>) -> Void)
    // Функционал для работы с категориями
    func categoryGetList(limit: Int, offset: Int, completion: @escaping (Result<GetCategoryListResponse, Error>) -> Void)
    func categoryCreate(category: CategoryGrade, completion: @escaping (Result<CategoryGrade, Error>) -> Void)
    func categoryRead(id: Int, completion: @escaping (Result<CategoryGrade, Error>) -> Void)
    func categoryUpdate(id: Int, category: CategoryGrade, completion: @escaping (Result<CategoryGrade, Error>) -> Void)
    func categoryDelete(id: Int, completion: @escaping (Result<String, Error>) -> Void)
    // Функционал работы с sectionami
    func sectionGetList(limit: Int, offset: Int, completion: @escaping (Result<GetSectionListResponse, Error>) -> Void)
    func sectionCreate(section: Section, completion: @escaping (Result<Section, Error>) -> Void)
    func sectionBaseGetList(limit: Int, offset: Int, completion: @escaping (Result<GetSectionListResponse, Error>) -> Void)
    func sectionRead(id: Int, completion: @escaping (Result<Section, Error>) -> Void)
    func sectionUpdate(id: Int, section: Section, completion: @escaping (Result<Section, Error>) -> Void)
    func sectionDelete(id: Int, completion: @escaping (Result<String, Error>) -> Void)
    
    static var token: String! { get set }
    

}

public class AsapService {
    static let environment : NetworkEnvironment = .staging
    public static var token : String!
    let router = Router<AsapApi>()
    
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
}

extension AsapService: AsapServiceProtocol {
	
	private func routerRequest<T: Codable>(_ route: AsapApi, decodeType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
		router.request(route, completion: { data, response, error in
			
			guard error == nil else {
				completion(.failure(error!))
				return
			}
			
			guard let response = response as? HTTPURLResponse else {
				completion(.failure(NetworkResponse.ubableToDecode))
				return
			}
			
			let result = self.handleNetworkResponse(response)
			switch result {
				case .success:
					guard let responseData = data else {
						completion(.failure(NetworkResponse.noData))
						return
					}
					do {
						let apiResponse: T = try JSONDecoder().decode(decodeType, from: responseData)
						completion(.success(apiResponse))
					} catch {
						completion(.failure(NetworkResponse.ubableToDecode))
					}
					
				case .failure(let failureError):
					completion(.failure(failureError))
			}
		})
	}
	
    /// Получить список всех чатов
    /// - Parameter isActive: если  true то все активные чаты, иначе чаты архива
    /// - Parameter limit: лимит чатов в запросе
    /// - Parameter offset: смещение чатов в запросе
    public func chatGetList(isActive: Bool, limit: Int, offset: Int, completion: @escaping (Result<GetChatListResponse, Error>) -> Void) {
		routerRequest(.chatGetList(isActive: isActive, limit: limit, offset: offset),
					  decodeType: GetChatListResponse.self,
					  completion: completion)
    }
    /// Создать чат
    /// - Parameter chat: экземпляр класса чата для его создания (описан в сущности Chat)
    public func chatCreate(chat: Chat, completion: @escaping (Result<Chat, Error>) -> Void) {
		routerRequest(.chatCreate(chat: chat),
					  decodeType: Chat.self,
					  completion: completion)
    }
    
    /// Переместить чат в архив
    /// - Parameter id: ид чата который мы перемещаем в архив
    public func chatToAchive(id: Int, completion: @escaping (Result<Chat, Error>) -> Void) {
		routerRequest(.chatToArchive(id: id),
					  decodeType: Chat.self,
					  completion: completion)
    }
    
    /// Возвращает список всех разрешений(действий в ате) которые есть
    public func chatGetAppPermissions(completion: @escaping (Result<[PermissionAction], Error>) -> Void) {
		routerRequest(.chatGetAllPermissions,
					  decodeType: [PermissionAction].self,
					  completion: completion)
    }
    
    /// Добавляет мембера в чат
    /// - Parameter member: передается модель Member, передаются все поля кроме id (id передавать не нужно)
    public func chatMemberCreate(member: Member, completion: @escaping (Result<Member, Error>) -> Void) {
		routerRequest(.chatMemberCreate(member: member),
					  decodeType: Member.self,
					  completion: completion)
    }
    
    /// Изменяет роль мембера для данного чата
    /// - Parameter chatId: идентификатор чата
    /// - Parameter userId: идентификатор пользователся
    /// - Parameter member: данные мембера (передаются только isOwner и Role, остальные параметры передавать не нужно
    
    public func chatMemberUpdate(chatId: Int, userId: Int, member: Member, completion: @escaping (Result<MemberUpdate, Error>) -> Void) {
		routerRequest(.chatMemberUpdate(chatId: chatId, userId: userId, member: member),
					  decodeType: MemberUpdate.self,
					  completion: completion)
    }
    
    public func chatMemberDelete(chatId: Int, userId: Int, completion: @escaping (Result<String, Error>) -> Void) {
		routerRequest(.chatMemberDelete(chatId: chatId, userId: userId),
					  decodeType: String.self,
					  completion: completion)
    }
    
    /// Возвращает информацию по чату
    /// - Parameter id: идентификатор
    public func chatRead(id: Int, completion: @escaping (Result<Chat, Error>) -> Void) {
		routerRequest(.chatRead(id: id),
					  decodeType: Chat.self,
					  completion: completion)
    }
    
    /// Изменяет данные чата
    /// - Parameter id: идентификатор чата
    /// - Parameter chat: данные чата
    public func chatUpdate(id: Int, chat: Chat, completion: @escaping (Result<Chat, Error>) -> Void) {
		routerRequest(.chatUpdate(id: id, chat: chat),
					  decodeType: Chat.self,
					  completion: completion)
    }
    
    /// Удаляет чат
    /// - Parameter id: идентификатор чата
    public func chatDelete(id: Int, completion: @escaping (Result<String, Error>) -> Void) {
		routerRequest(.chatDelete(id: id),
					  decodeType: String.self,
					  completion: completion)
    }
    
    // TODO LOAD AVATAR
    //
    //
    //
    //
    //
    //
    //
    
    // Контакты
    /// Получить список контактов
    /// - Parameter limit: Количество выведеных результатов
    /// - Parameter offset: Смещение
   public func contactsGetList(limit: Int, offset: Int, completion: @escaping (Result<GetContactsListResponse, Error>) -> Void) {
	routerRequest(.contactsGetList(limit: limit, offset: offset),
				  decodeType: GetContactsListResponse.self,
				  completion: completion)
    }
    
    /// Создать контакт
    /// - Parameter contact: данные контакта
    public func contactCreate(contact: Contact, completion: @escaping (Result<Contact, Error>) -> Void) {
		routerRequest(.contactsCreate(contact: contact),
					  decodeType: Contact.self,
					  completion: completion)
    }
    
    /// Получить инфо по контакту
    /// - Parameter id: идентификатор контакта
    public func contactRead(id: Int, completion: @escaping (Result<Contact, Error>) -> Void) {
		routerRequest(.contactsRead(id: id),
					  decodeType: Contact.self,
					  completion: completion)
    }
    
    /// Изменить данные контакта
    /// - Parameter contact: данны контакта
    /// - Parameter id: идентификатор контакта
    public func contactUpdate(contact: Contact, id: Int, completion: @escaping (Result<Contact, Error>) -> Void){
		routerRequest(.contactsUpdate(contact: contact, id: id),
					  decodeType: Contact.self,
					  completion: completion)
    }
    
    /// Удалить контакт
    /// - Parameter id: идентификатор контакта
    public func contactDelete(id: Int, completion: @escaping (Result<String, Error>) -> Void){
		routerRequest(.contactsDelete(id: id),
					  decodeType: String.self,
					  completion: completion)
    }
    
    public func contactsOwnerGetList(ownerProfileId: Int, limit: Int, offset: Int, completion: @escaping (Result<GetContactsListResponse, Error>) -> Void) {
		routerRequest(.contactsOwnerGetList(ownerProfileId: ownerProfileId,
											limit: limit,
											offset: offset),
					  decodeType: GetContactsListResponse.self,
					  completion: completion)
    }

    /// Получить список все категорий
    /// - Parameter limit: Количество выведеных результатов
    /// - Parameter offset: Смещение
    public func categoryGetList(limit: Int, offset: Int, completion: @escaping (Result<GetCategoryListResponse, Error>) -> Void) {
		routerRequest(.categoryGetList(limit: limit, offset: offset),
					  decodeType: GetCategoryListResponse.self,
					  completion: completion)
    }

    /// Создать категорию
    /// - Parameter category: передает категорию для ее создания
    public func categoryCreate(category: CategoryGrade, completion: @escaping (Result<CategoryGrade, Error>) -> Void){
		routerRequest(.categoryCreate(category: category),
					  decodeType: CategoryGrade.self,
					  completion: completion)
    }
    
    /// Возвращает детальную информацию по категории
    /// - Parameter id: идентификатор категории
    public func categoryRead(id: Int, completion: @escaping (Result<CategoryGrade, Error>) -> Void){
		routerRequest(.categoryRead(id: id),
					  decodeType: CategoryGrade.self,
					  completion: completion)
    }
    
    /// Изменяет данные категории
    /// - Parameter id: идентификатор категории
    /// - Parameter category: экземпляр категории
    public func categoryUpdate(id: Int, category: CategoryGrade, completion: @escaping (Result<CategoryGrade, Error>) -> Void){
		routerRequest(.categoryUpdate(id: id, categoty: category),
					  decodeType: CategoryGrade.self,
					  completion: completion)
    }
    
    /// Удаляет категорию
    /// - Parameter id: идентификатор категории
    public func categoryDelete(id: Int, completion: @escaping (Result<String, Error>) -> Void){
		routerRequest(.categoryDelete(id: id),
					  decodeType: String.self,
					  completion: completion)
    }
    
    /// Возвращает список сех секций
    /// - Parameter limit: Количество выведеных результатов
    /// - Parameter offset: Смещение
    public func sectionGetList(limit: Int, offset: Int, completion: @escaping (Result<GetSectionListResponse, Error>) -> Void){
		routerRequest(.sectionGetList(limit: limit, offset: offset),
					  decodeType: GetSectionListResponse.self,
					  completion: completion)
    }
    
    /// Создает секцию
    /// - Parameter section: задает экземпляр класса секции для ее создания
    public func sectionCreate(section: Section, completion: @escaping (Result<Section, Error>) -> Void){
		routerRequest(.sectionCreate(section: section),
					  decodeType: Section.self,
					  completion: completion)
    }
    
    /// Возвращает список всех базовых секций
    /// - Parameter limit: Количество выведеных результатов
    /// - Parameter offset: Смещение
    public func sectionBaseGetList(limit: Int, offset: Int, completion: @escaping (Result<GetSectionListResponse, Error>) -> Void){
		routerRequest(.sectionBaseGetList(limit: limit, offset: offset),
					  decodeType: GetSectionListResponse.self,
					  completion: completion)
    }
    
    /// Возвращает детальное описание секции
    /// - Parameter id: идентификатор секции
    public func sectionRead(id: Int, completion: @escaping (Result<Section, Error>) -> Void) {
		routerRequest(.sectionRead(id: id),
					  decodeType: Section.self,
					  completion: completion)
    }
    
    /// Вносит изменения в данные секции
    /// - Parameter id: идентификатор секции
    /// - Parameter section: данные секции
    public func sectionUpdate(id: Int, section: Section, completion: @escaping (Result<Section, Error>) -> Void) {
		routerRequest(.sectionUpdate(id: id, section: section),
					  decodeType: Section.self,
					  completion: completion)
    }
    
    /// Удаляет секцию
    /// - Parameter id: идентификатор секции
    public func sectionDelete(id: Int, completion: @escaping (Result<String, Error>) -> Void) {
		routerRequest(.sectionDelete(id: id),
					  decodeType: String.self,
					  completion: completion)
    }
}
