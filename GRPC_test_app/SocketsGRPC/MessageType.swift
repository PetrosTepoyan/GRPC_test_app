//
//  MessageType.swift
//  
//
//  Created by Алексей Плакош on 13.08.2021.
//

import Foundation
import SwiftProtobuf


public typealias MessageEntity = Service_Message
extension MessageEntity {
	internal init(id: String,
				  from: Int64,
				  to: Int64,
				  type: Service_MessageTypes,
				  status: Service_MessageStatuses,
				  chatType: Service_ChatTypes,
				  isFavorite: Bool = false,
				  views: Int = 0,
				  createdAt: Double = Date().timeIntervalSince1970,
				  updatedAt: Double? = nil,
				  deletedAt: Double? = nil) {
		self.id = id
		self.from = from
		self.to = to
		self.type = type
		self.status = status
		self.chatType = chatType
		self.isFavorite = isFavorite
		self.views = Int64(views)
		self.createdAt = TimeStamp(doubleTime: createdAt)
		self.upatedAt = TimeStamp(doubleTime: updatedAt)
		self.deletedAt = TimeStamp(doubleTime: deletedAt)
	}
}

private func decodeToType(type: Service_MessageTypes) -> MessageType {
    switch type {
    case .choose: return .choose
    case .chronic: return .chronic
    case .forward: return .forward
    case .media: return .media
    case .moment: return .moment
    case .news: return .news
    case .profile: return .profile
    case .profilePhoto: return .profilePhoto
    case .quote: return .quote
    case .system: return .system
    case .text: return .text
    case let .UNRECOGNIZED(code): return .unrecognised(code: code)
    }
}

private func decodeToStatus(status: Service_MessageStatuses) -> MessageStatus {
    switch status {
    case .error: return .error
    case .readed: return .readed
    case .recieved: return .recived
    case let .UNRECOGNIZED(code): return .unrecognised(code: code)
    }
}

private func decodeToChatType(chatType: Service_ChatTypes) -> ChatType {
    switch chatType {
    case .group: return .group
    case .direct: return .direct
    case .channel: return .channel
    case let .UNRECOGNIZED(code): return .unrecognised(code: code)
    }
}

public enum MessageType {
    case text
    case media
    case forward
    case quote
    case chronic
    case profile
    case profilePhoto
    case moment
    case news
    case choose
    case system
    case unrecognised(code: Int)
}

public enum MessageStatus {
    case recived
    case readed
    case error
    case unrecognised(code: Int)
}

public enum ChatType {
    case direct
    case group
    case channel
    case unrecognised(code: Int)
}

public typealias TimeStamp = Google_Protobuf_Timestamp

extension TimeStamp {
    
    // Инициализатор для работы декодера
    internal init(timeStamp: Google_Protobuf_Timestamp) {
		self.init()
        self.seconds = timeStamp.seconds
        self.nanos = timeStamp.nanos
    }
    
    // Публичный инициализатор для вызова извне
    public init(seconds: Int64, nanos: Int32) {
		self.init()
        self.seconds = seconds
        self.nanos = nanos
    }
	
	
	public init(doubleTime: Double? = nil) {
		self.init()
		if let doubleTime = doubleTime {
			self.seconds = Int64(floor(doubleTime))
			self.nanos = Int32(doubleTime.truncatingRemainder(dividingBy: 1))
		} else  {
			let currentTime = Date().timeIntervalSince1970
			self.seconds = Int64(floor(currentTime))
			self.nanos = Int32(currentTime.truncatingRemainder(dividingBy: 1))
		}
	}
	
}

struct AuthEntity {
	
	var token: MTText {
		get {
			return _token ?? MTText()
		}
		set {
			_token = newValue
		}
	}
	/// Returns true if `token` has been explicitly set.
	var hasToken: Bool {
		return self._token != nil
	}
	/// Clears the value of `token`. Subsequent reads from it will return its default value.
	mutating func clearToken() {
		self._token = nil
	}
	
	var unknownFields = SwiftProtobuf.UnknownStorage()
	
	init() {}
	
	fileprivate var _token: MTText? = nil
}

extension AuthEntity: Equatable {
	static func ==(lhs: AuthEntity, rhs: AuthEntity) -> Bool {
		if lhs._token?.text != rhs._token?.text { return false }
		if lhs.unknownFields != rhs.unknownFields { return false }
		return true
	}
}

protocol ServiceContentType {}

typealias MTChoose = Service_MTChoose
typealias MTChronical = Service_MTChronicle
typealias MTForwardMessage = Service_MTForwardMessage
typealias MTMedia = Service_MTMedia
typealias MTMoment = Service_MTMoment
typealias MTProfile = Service_MTProfile
typealias MTProfilePhoto = Service_MTProfilePhoto
typealias MTQuoteMessage = Service_MTQuoteMessage
typealias MTText = Service_MTText

extension MTChoose : ServiceContentType {}
extension MTChronical : ServiceContentType {}
extension MTForwardMessage : ServiceContentType {}
extension MTMedia : ServiceContentType {}
extension MTMoment : ServiceContentType {}
extension MTProfile : ServiceContentType {}
extension MTProfilePhoto : ServiceContentType {}
extension MTQuoteMessage : ServiceContentType {}

extension MTText : ServiceContentType {
	init(text: String) {
		self.text = text
	}
}

