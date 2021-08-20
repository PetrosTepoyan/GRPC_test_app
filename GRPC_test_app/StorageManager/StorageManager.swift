//
//  File.swift
//  
//
//  Created by Алексей Плакош on 15.06.2021.
//

import Foundation
import RealmSwift

public protocol StorageServiceProtocol {
    func createCatalog() -> Bool
    func openCatalog() -> Bool
    func deleteCatalog() -> Bool
    func saveMessage(id: Int64, chatId: Int64, text: String, fileUrl: String?, date: String, time: String) -> Bool
    func editMessage(id: Int64, chatId: Int64, text: String, fileUrl: String?, date: String, time: String) -> Bool
    func deleteMessage(id: Int64, chatId: Int64) -> Bool
}

public class StorageService {
    private var storage : Realm!
    
    public init() throws {
        do {
            storage = try Realm()
        } catch {
            throw error
        }
    }
}

extension StorageService: StorageServiceProtocol{
    public func createCatalog() -> Bool {
        //
        return true
    }
    
    public func openCatalog() -> Bool {
        //
        return true
    }
    
    public func deleteCatalog() -> Bool {
        //
        return true
    }
    
    public func saveMessage(id: Int64, chatId: Int64, text: String, fileUrl: String? = nil, date: String, time: String) -> Bool {
        let message = MessagesDB()
        message.id = id
        message.chatId = chatId
        message.text = text
        message.fileUrl = fileUrl ?? ""
        message.date = date
        message.time = time
        do {
            try storage.write{
                storage.add(message)
            }
            return true
        } catch {
            return false
        }
    }
    
    public func editMessage(id: Int64, chatId: Int64, text: String, fileUrl: String? = nil, date: String, time: String) -> Bool {
        do {
            let message = storage.objects(MessagesDB.self).filter("id == \(id) AND chatId == \(chatId)").first
            try storage.write{
                message?.text = text
                message?.fileUrl = fileUrl ?? ""
                message?.date = date
                message?.time = time
            }
            return true
        } catch {
            return false
        }
    }
    
    public func deleteMessage(id: Int64, chatId: Int64) -> Bool {
        do {
            try storage.write{
                storage.delete(storage.objects(MessagesDB.self).filter("id == \(id) AND chatId == \(chatId)"))
            }
            return true
        } catch {
            return false
        }
    }
    
    
}
