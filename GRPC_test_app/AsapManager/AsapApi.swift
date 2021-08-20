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
public enum AsapApi {
    // Chat
    case chatGetList(isActive: Bool, limit: Int, offset: Int) // get
    case chatCreate(chat: Chat) // post
    case chatToArchive(id: Int)//asap/chat/add_to_archive/{chat_id}/
    case chatGetAllPermissions
    case chatMemberCreate(member: Member)
    case chatMemberUpdate(chatId: Int, userId: Int, member: Member)
    case chatMemberDelete(chatId: Int, userId: Int)
    case chatRead(id: Int)
    case chatUpdate(id: Int, chat: Chat) // put
    case chatDelete(id: Int) // delete
//    case chetUploadAvatar(id: Int, photo: Data)
    
//    // Category категории
    case categoryGetList(limit: Int, offset: Int) // get
    case categoryCreate(category: CategoryGrade) // post
    case categoryRead(id: Int)
    case categoryUpdate(id: Int, categoty: CategoryGrade)
    case categoryDelete(id: Int)
//
//    //Contacts
    case contactsGetList(limit: Int, offset: Int) // get
    case contactsCreate(contact: Contact) // post
    case contactsRead(id: Int) // get
    case contactsUpdate(contact: Contact, id: Int) // put
    case contactsDelete(id: Int) // delete
    case contactsOwnerGetList(ownerProfileId: Int, limit: Int, offset: Int)
//
//    // Section
    case sectionGetList(limit: Int, offset: Int) // get
    case sectionCreate(section: Section) // post
    case sectionBaseGetList(limit: Int, offset: Int)
    case sectionRead(id: Int)
    case sectionUpdate(id: Int, section: Section)
    case sectionDelete(id: Int)
}

// Экстеншен для формирования эндпоинта АСАП
extension AsapApi : EndPointType {
 
    
    var environmentBaseURL : String {
         switch AsapService.environment {
         case .production: return "http://core.test.sfera-app.ru/api/v1"
         case .qa: return "http://core.test.sfera-app.ru/api/v1"
         case .staging: return "http://core.test.sfera-app.ru/api/v1"
         }
     }
    
    public var baseUrl: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
                return url
    }
    
    public var path: String {
        switch self {
        case .chatGetList:
            return "/asap/chat/"
        case .chatCreate:
            return "/asap/chat/"
        case .chatToArchive(id: let id):
            return "/asap/chat/add_to_archive/\(id)/"
        case .chatGetAllPermissions:
            return "/asap/chat/get_all_perm/"
        case .chatMemberCreate:
            return "/asap/chat/member/"
        case .chatMemberUpdate(chatId: let chatId, userId: let userId, member: _):
            return "/asap/chat/member/\(chatId)/\(userId)/"
        case .chatMemberDelete(chatId: let chatId, userId: let userId):
            return "/asap/chat/member/\(chatId)/\(userId)/"
        case .chatRead(id: let id):
            return "/asap/chat/\(id)/"
        case .chatUpdate(id: let id, chat: _):
            return "/asap/chat/\(id)/"
        case .chatDelete(id: let id):
            return "/asap/chat/\(id)/"
        // TODO LOAD AVATAR
        //
        //
        //
        //
        //
        //
        //
        case .categoryGetList:
            return "/category/"
        case .categoryCreate:
            return "/category/"
        case .categoryRead(id: let id):
            return "/category/\(id)/"
        case .categoryUpdate(id: let id, categoty: _):
            return "/category/\(id)/"
        case .categoryDelete(id: let id):
            return "/category/\(id)/"
        case .contactsGetList:
            return "/contacts/"
        case .contactsCreate:
            return "/contacts/"
        case .contactsRead(id: let id):
            return "/contacts/\(id)/"
        case .contactsUpdate(contact: _, id: let id):
            return "/contacts/\(id)/"
        case .contactsDelete(id: let id):
            return "/contacts/\(id)/"
        case .contactsOwnerGetList(ownerProfileId: let id, limit: _, offset: _):
            return "/contacts/\(id)/contacts/"
        case .sectionGetList:
            return "/section/"
        case .sectionCreate:
            return "/section/"
        case .sectionBaseGetList:
            return "/section/base/"
        case .sectionRead(id: let id):
            return "/section/\(id)/"
        case .sectionUpdate(id: let id, section: _):
            return "/section/\(id)/"
        case .sectionDelete(id: let id):
            return "/section/\(id)/"
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .chatGetList:
            return .get
        case .chatCreate:
            return .post
        case .chatToArchive:
            return .get
        case .chatGetAllPermissions:
            return .get
        case .chatMemberCreate:
            return .post
        case .chatMemberUpdate:
            return .put
        case .chatMemberDelete:
            return .delete
        case .chatRead:
            return .get
        case .chatUpdate:
            return .put
        case .chatDelete:
            return .delete
        // TODO LOAD AVATAR
        //
        //
        //
        //
        //
        //
        //
        case .categoryGetList:
            return .get
        case .categoryCreate:
            return .post
        case .categoryRead:
            return .get
        case .categoryUpdate:
            return .put
        case .categoryDelete:
            return .delete
        case .contactsGetList:
            return .get
        case .contactsCreate:
            return .post
        case .contactsRead:
            return .get
        case .contactsUpdate:
            return .put
        case .contactsDelete:
            return .delete
        case .contactsOwnerGetList:
            return .get
        case .sectionGetList:
            return .get
        case .sectionCreate:
            return .post
        case .sectionBaseGetList:
            return .get
        case .sectionRead:
            return .get
        case .sectionUpdate:
            return .put
        case .sectionDelete:
            return .delete
        }
    }
    
    public var httpTask: HTTPTask {
        switch self {
        case .chatGetList:
            return .request
        case .chatCreate:
            return .request
        case .chatToArchive:
            return .request
        case .chatGetAllPermissions:
            return .request
        case .chatMemberCreate:
            return .request
        case .chatMemberUpdate:
            return .request
        case .chatMemberDelete:
            return .request
        case .chatRead:
            return .request
        case .chatUpdate:
            return .request
        case .chatDelete:
            return .request
        // TODO LOAD AVATAR
        //
        //
        //
        //
        //
        //
        //
        case .categoryGetList:
            return .request
        case .categoryCreate:
            return .request
        case .categoryRead:
            return .request
        case .categoryUpdate:
            return .request
        case .categoryDelete:
            return .request
        case .contactsGetList:
            return .request
        case .contactsCreate:
            return .request
        case .contactsRead:
            return .request
        case .contactsUpdate:
            return .request
        case .contactsDelete:
            return .request
        case .contactsOwnerGetList:
            return .request
        case .sectionGetList:
            return .request
        case .sectionCreate:
            return .request
        case .sectionBaseGetList:
            return .request
        case .sectionRead:
            return .request
        case .sectionUpdate:
            return .request
        case .sectionDelete:
            return .request

        }
    }
    
    public var bodyParametrs: BodyParameters? {
        switch self {
        case .chatGetList:
            return nil
        case .chatCreate(chat: let chat):
            do {
                let dictionary = try DictionaryEncoder().encode(chat)
                return dictionary
            } catch  {
                return nil
            }
        case .chatToArchive:
            return nil
        case .chatGetAllPermissions:
            return nil
        case .chatMemberCreate(member: let member):
            do {
                let dictionary = try DictionaryEncoder().encode(member)
                return dictionary
            } catch  {
                return nil
            }
        case .chatMemberUpdate(chatId: _, userId: _, member: let member):
            do {
                let dictionary = try DictionaryEncoder().encode(member)
                return dictionary
            } catch  {
                return nil
            }
        case .chatMemberDelete:
            return nil
        case .chatRead:
            return nil
        case .chatUpdate(id: _, chat: let chat):
            do {
                let dictionary = try DictionaryEncoder().encode(chat)
                return dictionary
            } catch  {
                return nil
            }
        case .chatDelete:
            return nil
        // TODO LOAD AVATAR
        //
        //
        //
        //
        //
        //
        //
        case .categoryGetList:
            return nil
        case .categoryCreate(category: let category):
            do {
                let dictionary = try DictionaryEncoder().encode(category)
                return  dictionary
            } catch  {
                return nil
            }
        case .categoryRead:
            return nil
        case .categoryUpdate(id: _, categoty: let categoty):
            do {
                let dictionary = try DictionaryEncoder().encode(categoty)
                return dictionary
            } catch  {
                return nil
            }
        case .categoryDelete:
            return nil
        case .contactsGetList:
            return nil
        case .contactsCreate(contact: let contact):
            do {
                let dictionary = try DictionaryEncoder().encode(contact)
                return dictionary
            } catch  {
                return nil
            }
        case .contactsRead:
            return nil
        case .contactsUpdate(contact: let contact, id: _):
            do {
                let dictionary = try DictionaryEncoder().encode(contact)
                return  dictionary
            } catch  {
                return nil
            }
        case .contactsDelete:
            return nil
        case .contactsOwnerGetList:
            return nil
        case .sectionGetList:
            return nil
        case .sectionCreate(section: let section):
            do {
                let dictionary = try DictionaryEncoder().encode(section)
                return dictionary
            } catch  {
                return nil
            }
        case .sectionBaseGetList:
            return nil
        case .sectionRead:
            return nil
        case .sectionUpdate(id: _, section: let section):
            do {
                let dictionary = try DictionaryEncoder().encode(section)
                return dictionary
            } catch  {
                return nil
            }
        case .sectionDelete:
            return nil
        }
    }
    
    public var urlParameters: URLParameters? {
        switch self {
        case .chatGetList(isActive: let isActive, limit: let limit, offset: let offset):
            return ["is_active" : isActive,
                    "limit": limit,
                    "offset": offset]
        case .chatCreate:
                return nil
        case .chatToArchive:
            return nil
        case .chatGetAllPermissions:
            return nil
        case .chatMemberCreate:
            return nil
        case .chatMemberUpdate:
            return nil
        case .chatMemberDelete:
            return nil
        case .chatRead:
            return nil
        case .chatUpdate:
            return nil
        case .chatDelete:
            return nil
        // TODO LOAD AVATAR
        //
        //
        //
        //
        //
        //
        //
        case .categoryGetList(limit: let limit, offset: let offset):
            return ["limit": limit,
                    "offset": offset]
        case .categoryCreate:
            return nil
        case .categoryRead:
            return nil
        case .categoryUpdate:
            return nil
        case .categoryDelete:
            return nil
        case .contactsGetList(limit: let limit, offset: let offset):
            return ["limit": limit,
                    "offset": offset]
        case .contactsCreate:
            return nil
        case .contactsRead:
            return nil
        case .contactsUpdate:
            return nil
        case .contactsDelete:
            return nil
        case .contactsOwnerGetList(ownerProfileId: _, limit: let limit, offset: let offset):
            return ["limit": limit,
                    "offset": offset]
        case .sectionGetList(limit: let limit, offset: let offset):
            return ["limit": limit,
                    "offset": offset]
        case .sectionCreate:
            return nil
        case .sectionBaseGetList(limit: let limit, offset: let offset):
            return ["limit": limit,
                    "offset": offset]
        case .sectionRead:
            return nil
        case .sectionUpdate:
            return nil
        case .sectionDelete:
            return nil

        }
    }
    
    public var fields: Fields? {
        switch self {
        case .chatGetList:
            return ["accept":"application/json"]
        case .chatCreate:
            return ["accept":"application/json",
                    "Content-Type":"application/json"]
        case .chatToArchive:
            return ["accept":"application/json"]
        case .chatGetAllPermissions:
            return ["accept":"application/json"]
        case .chatMemberCreate:
            return ["accept":"application/json",
                    "Content-Type":"application/json"]
        case .chatMemberUpdate:
            return ["accept":"application/json",
                    "Content-Type":"application/json"]
        case .chatMemberDelete:
            return ["accept":"application/json"]
        case .chatRead:
            return ["accept":"application/json"]
        case .chatUpdate:
            return ["accept":"application/json",
                    "Content-Type":"application/json"]
        case .chatDelete:
            return ["accept":"application/json"]
    // TODO LOAD AVATAR
        //
        //
        //
        //
        //
        //
        //
        case .categoryGetList:
            return ["accept":"application/json"]
        case .categoryCreate:
            return ["accept":"application/json",
                    "Content-Type":"application/json"]
        case .categoryRead:
            return ["accept":"application/json"]
        case .categoryUpdate:
            return ["accept":"application/json",
                    "Content-Type":"application/json"]
        case .categoryDelete:
            return ["accept":"application/json"]
        case .contactsGetList:
            return ["accept":"application/json"]
        case .contactsCreate:
            return ["accept":"application/json",
                    "Content-Type":"application/json"]
        case .contactsRead:
            return ["accept":"application/json"]
        case .contactsUpdate:
            return ["accept":"application/json",
                    "Content-Type":"application/json"]
        case .contactsDelete:
            return ["accept":"application/json"]
        case .contactsOwnerGetList:
            return ["accept":"application/json"]
        case .sectionGetList:
            return ["accept":"application/json"]
        case .sectionCreate:
            return ["accept":"application/json",
                    "Content-Type":"application/json"]
        case .sectionBaseGetList:
            return ["accept":"application/json"]
        case .sectionRead:
            return ["accept":"application/json"]
        case .sectionUpdate:
            return ["accept":"application/json",
                    "Content-Type":"application/json"]
        case .sectionDelete:
            return ["accept":"application/json"]
        }
    }
    
    public var httpHeaders: HTTPHeader? {
        switch self {
        default:
            return ["Authorization" : AsapService.token ?? "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6MTIzMTIzMTIzLCJGaXJzdE5hbWUiOiJKb2huIiwiTGFzdE5hbWUiOiJEb2UiLCJOaWNrbmFtZSI6Ikpvbm55RCJ9.6YYTkrC3p3p1Q0Zf6pIXcYLR3GMlapCqGAkn5Vaznig"]
        }
    }
    
    
}

