//
//  File.swift
//  
//
//  Created by Алексей Плакош on 25.06.2021.
//

import Foundation
import RealmSwift

class MessagesDB: Object {
    @objc dynamic var id : Int64 = 0
    @objc dynamic var chatId : Int64 = 0
    @objc dynamic var text : String = ""
    @objc dynamic var fileUrl : String = ""
    @objc dynamic var date : String = ""
    @objc dynamic var time : String = ""
}
