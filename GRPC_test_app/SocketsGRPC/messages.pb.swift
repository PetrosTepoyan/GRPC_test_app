// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: messages.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}
// Converted to Swift
enum Service_MessageTypes: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case text // = 0
  case media // = 1
  case forward // = 2
  case quote // = 3
  case chronic // = 4
  case profile // = 5
  case profilePhoto // = 6
  case moment // = 7
  case news // = 8
  case choose // = 9
  case system // = 10
  case UNRECOGNIZED(Int)

  init() {
    self = .text
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .text
    case 1: self = .media
    case 2: self = .forward
    case 3: self = .quote
    case 4: self = .chronic
    case 5: self = .profile
    case 6: self = .profilePhoto
    case 7: self = .moment
    case 8: self = .news
    case 9: self = .choose
    case 10: self = .system
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .text: return 0
    case .media: return 1
    case .forward: return 2
    case .quote: return 3
    case .chronic: return 4
    case .profile: return 5
    case .profilePhoto: return 6
    case .moment: return 7
    case .news: return 8
    case .choose: return 9
    case .system: return 10
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Service_MessageTypes: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Service_MessageTypes] = [
    .text,
    .media,
    .forward,
    .quote,
    .chronic,
    .profile,
    .profilePhoto,
    .moment,
    .news,
    .choose,
    .system,
  ]
}

#endif  // swift(>=4.2)
// Converted to Swift
enum Service_MessageStatuses: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case recieved // = 0
  case readed // = 1
  case error // = 2
  case UNRECOGNIZED(Int)

  init() {
    self = .recieved
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .recieved
    case 1: self = .readed
    case 2: self = .error
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .recieved: return 0
    case .readed: return 1
    case .error: return 2
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Service_MessageStatuses: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Service_MessageStatuses] = [
    .recieved,
    .readed,
    .error,
  ]
}

#endif  // swift(>=4.2)
// Converted to Swift
enum Service_ChatTypes: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case direct // = 0
  case group // = 1
  case channel // = 2
  case UNRECOGNIZED(Int)

  init() {
    self = .direct
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .direct
    case 1: self = .group
    case 2: self = .channel
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .direct: return 0
    case .group: return 1
    case .channel: return 2
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Service_ChatTypes: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Service_ChatTypes] = [
    .direct,
    .group,
    .channel,
  ]
}

#endif  // swift(>=4.2)
// Converted to Swift
struct Service_StreamResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var timestamp: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _timestamp ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_timestamp = newValue}
  }
  /// Returns true if `timestamp` has been explicitly set.
  var hasTimestamp: Bool {return self._timestamp != nil}
  /// Clears the value of `timestamp`. Subsequent reads from it will return its default value.
  mutating func clearTimestamp() {self._timestamp = nil}

  var event: Service_StreamResponse.OneOf_Event? = nil

  var message: Service_Message {
    get {
      if case .message(let v)? = event {return v}
      return Service_Message()
    }
    set {event = .message(newValue)}
  }

  var auth: Service_Auth {
    get {
      if case .auth(let v)? = event {return v}
      return Service_Auth()
    }
    set {event = .auth(newValue)}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_Event: Equatable {
    case message(Service_Message)
    case auth(Service_Auth)

  #if !swift(>=4.1)
    static func ==(lhs: Service_StreamResponse.OneOf_Event, rhs: Service_StreamResponse.OneOf_Event) -> Bool {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch (lhs, rhs) {
      case (.message, .message): return {
        guard case .message(let l) = lhs, case .message(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.auth, .auth): return {
        guard case .auth(let l) = lhs, case .auth(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      default: return false
      }
    }
  #endif
  }

  init() {}

  fileprivate var _timestamp: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
}

struct Service_StreamRequest {
  var event: Service_StreamRequest.OneOf_Event? = nil

  var message: Service_Message {
    get {
      if case .message(let v)? = event {return v}
      return Service_Message()
    }
    set {event = .message(newValue)}
  }

  var auth: Service_Auth {
    get {
      if case .auth(let v)? = event {return v}
      return Service_Auth()
    }
    set {event = .auth(newValue)}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_Event: Equatable {
    case message(Service_Message)
    case auth(Service_Auth)

  #if !swift(>=4.1)
    static func ==(lhs: Service_StreamRequest.OneOf_Event, rhs: Service_StreamRequest.OneOf_Event) -> Bool {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch (lhs, rhs) {
      case (.message, .message): return {
        guard case .message(let l) = lhs, case .message(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.auth, .auth): return {
        guard case .auth(let l) = lhs, case .auth(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      default: return false
      }
    }
  #endif
  }

  init() {}
}

public struct Service_Message {
  /// system field
  var recipient: [Int64] {
    get {return _storage._recipient}
    set {_uniqueStorage()._recipient = newValue}
  }

  var id: String {
    get {return _storage._id}
    set {_uniqueStorage()._id = newValue}
  }

  /// user who sent message
  var from: Int64 {
    get {return _storage._from}
    set {_uniqueStorage()._from = newValue}
  }

  /// a chat id or a contact id who was recieve this the message
  var to: Int64 {
    get {return _storage._to}
    set {_uniqueStorage()._to = newValue}
  }

  var type: Service_MessageTypes {
    get {return _storage._type}
    set {_uniqueStorage()._type = newValue}
  }

  var status: Service_MessageStatuses {
    get {return _storage._status}
    set {_uniqueStorage()._status = newValue}
  }

  var chatType: Service_ChatTypes {
    get {return _storage._chatType}
    set {_uniqueStorage()._chatType = newValue}
  }

  var isFavorite: Bool {
    get {return _storage._isFavorite}
    set {_uniqueStorage()._isFavorite = newValue}
  }

  /// views counter
  var views: Int64 {
    get {return _storage._views}
    set {_uniqueStorage()._views = newValue}
  }

  var createdAt: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _storage._createdAt ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_uniqueStorage()._createdAt = newValue}
  }
  /// Returns true if `createdAt` has been explicitly set.
  var hasCreatedAt: Bool {return _storage._createdAt != nil}
  /// Clears the value of `createdAt`. Subsequent reads from it will return its default value.
  mutating func clearCreatedAt() {_uniqueStorage()._createdAt = nil}

  var upatedAt: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _storage._upatedAt ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_uniqueStorage()._upatedAt = newValue}
  }
  /// Returns true if `upatedAt` has been explicitly set.
  var hasUpatedAt: Bool {return _storage._upatedAt != nil}
  /// Clears the value of `upatedAt`. Subsequent reads from it will return its default value.
  mutating func clearUpatedAt() {_uniqueStorage()._upatedAt = nil}

  var deletedAt: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _storage._deletedAt ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_uniqueStorage()._deletedAt = newValue}
  }
  /// Returns true if `deletedAt` has been explicitly set.
  var hasDeletedAt: Bool {return _storage._deletedAt != nil}
  /// Clears the value of `deletedAt`. Subsequent reads from it will return its default value.
  mutating func clearDeletedAt() {_uniqueStorage()._deletedAt = nil}

  var content: OneOf_Content? {
    get {return _storage._content}
    set {_uniqueStorage()._content = newValue}
  }

  var text: Service_MTText {
    get {
      if case .text(let v)? = _storage._content {return v}
      return Service_MTText()
    }
    set {_uniqueStorage()._content = .text(newValue)}
  }

  var media: Service_MTMedia {
    get {
      if case .media(let v)? = _storage._content {return v}
      return Service_MTMedia()
    }
    set {_uniqueStorage()._content = .media(newValue)}
  }

  var forward: Service_MTForwardMessage {
    get {
      if case .forward(let v)? = _storage._content {return v}
      return Service_MTForwardMessage()
    }
    set {_uniqueStorage()._content = .forward(newValue)}
  }

  var quote: Service_MTQuoteMessage {
    get {
      if case .quote(let v)? = _storage._content {return v}
      return Service_MTQuoteMessage()
    }
    set {_uniqueStorage()._content = .quote(newValue)}
  }

  var chronicle: Service_MTChronicle {
    get {
      if case .chronicle(let v)? = _storage._content {return v}
      return Service_MTChronicle()
    }
    set {_uniqueStorage()._content = .chronicle(newValue)}
  }

  var profile: Service_MTProfile {
    get {
      if case .profile(let v)? = _storage._content {return v}
      return Service_MTProfile()
    }
    set {_uniqueStorage()._content = .profile(newValue)}
  }

  var profilePhoto: Service_MTProfilePhoto {
    get {
      if case .profilePhoto(let v)? = _storage._content {return v}
      return Service_MTProfilePhoto()
    }
    set {_uniqueStorage()._content = .profilePhoto(newValue)}
  }

  var moment: Service_MTMoment {
    get {
      if case .moment(let v)? = _storage._content {return v}
      return Service_MTMoment()
    }
    set {_uniqueStorage()._content = .moment(newValue)}
  }

  var news: Service_MTNews {
    get {
      if case .news(let v)? = _storage._content {return v}
      return Service_MTNews()
    }
    set {_uniqueStorage()._content = .news(newValue)}
  }

  var choose: Service_MTChoose {
    get {
      if case .choose(let v)? = _storage._content {return v}
      return Service_MTChoose()
    }
    set {_uniqueStorage()._content = .choose(newValue)}
  }

	public var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_Content: Equatable {
    case text(Service_MTText)
    case media(Service_MTMedia)
    case forward(Service_MTForwardMessage)
    case quote(Service_MTQuoteMessage)
    case chronicle(Service_MTChronicle)
    case profile(Service_MTProfile)
    case profilePhoto(Service_MTProfilePhoto)
    case moment(Service_MTMoment)
    case news(Service_MTNews)
    case choose(Service_MTChoose)

  #if !swift(>=4.1)
    static func ==(lhs: Service_Message.OneOf_Content, rhs: Service_Message.OneOf_Content) -> Bool {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch (lhs, rhs) {
      case (.text, .text): return {
        guard case .text(let l) = lhs, case .text(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.media, .media): return {
        guard case .media(let l) = lhs, case .media(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.forward, .forward): return {
        guard case .forward(let l) = lhs, case .forward(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.quote, .quote): return {
        guard case .quote(let l) = lhs, case .quote(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.chronicle, .chronicle): return {
        guard case .chronicle(let l) = lhs, case .chronicle(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.profile, .profile): return {
        guard case .profile(let l) = lhs, case .profile(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.profilePhoto, .profilePhoto): return {
        guard case .profilePhoto(let l) = lhs, case .profilePhoto(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.moment, .moment): return {
        guard case .moment(let l) = lhs, case .moment(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.news, .news): return {
        guard case .news(let l) = lhs, case .news(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.choose, .choose): return {
        guard case .choose(let l) = lhs, case .choose(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      default: return false
      }
    }
  #endif
  }

  public init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct Service_MessageResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var timestamp: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _timestamp ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_timestamp = newValue}
  }
  /// Returns true if `timestamp` has been explicitly set.
  var hasTimestamp: Bool {return self._timestamp != nil}
  /// Clears the value of `timestamp`. Subsequent reads from it will return its default value.
  mutating func clearTimestamp() {self._timestamp = nil}

  var message: Service_Message {
    get {return _message ?? Service_Message()}
    set {_message = newValue}
  }
  /// Returns true if `message` has been explicitly set.
  var hasMessage: Bool {return self._message != nil}
  /// Clears the value of `message`. Subsequent reads from it will return its default value.
  mutating func clearMessage() {self._message = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _timestamp: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
  fileprivate var _message: Service_Message? = nil
}

struct Service_Auth {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var token: Service_MTText {
    get {return _token ?? Service_MTText()}
    set {_token = newValue}
  }
  /// Returns true if `token` has been explicitly set.
  var hasToken: Bool {return self._token != nil}
  /// Clears the value of `token`. Subsequent reads from it will return its default value.
  mutating func clearToken() {self._token = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _token: Service_MTText? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "service"

extension Service_MessageTypes: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "TEXT"),
    1: .same(proto: "MEDIA"),
    2: .same(proto: "FORWARD"),
    3: .same(proto: "QUOTE"),
    4: .same(proto: "CHRONIC"),
    5: .same(proto: "PROFILE"),
    6: .same(proto: "PROFILE_PHOTO"),
    7: .same(proto: "MOMENT"),
    8: .same(proto: "NEWS"),
    9: .same(proto: "CHOOSE"),
    10: .same(proto: "SYSTEM"),
  ]
}

extension Service_MessageStatuses: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "RECIEVED"),
    1: .same(proto: "READED"),
    2: .same(proto: "ERROR"),
  ]
}

extension Service_ChatTypes: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "DIRECT"),
    1: .same(proto: "GROUP"),
    2: .same(proto: "CHANNEL"),
  ]
}

extension Service_StreamResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".StreamResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "timestamp"),
    2: .same(proto: "message"),
    3: .same(proto: "auth"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._timestamp) }()
      case 2: try {
        var v: Service_Message?
        var hadOneofValue = false
        if let current = self.event {
          hadOneofValue = true
          if case .message(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.event = .message(v)
        }
      }()
      case 3: try {
        var v: Service_Auth?
        var hadOneofValue = false
        if let current = self.event {
          hadOneofValue = true
          if case .auth(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.event = .auth(v)
        }
      }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._timestamp {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    switch self.event {
    case .message?: try {
      guard case .message(let v)? = self.event else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }()
    case .auth?: try {
      guard case .auth(let v)? = self.event else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    }()
    case nil: break
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Service_StreamResponse, rhs: Service_StreamResponse) -> Bool {
    if lhs._timestamp != rhs._timestamp {return false}
    if lhs.event != rhs.event {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Service_StreamRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".StreamRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "message"),
    2: .same(proto: "auth"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try {
        var v: Service_Message?
        var hadOneofValue = false
        if let current = self.event {
          hadOneofValue = true
          if case .message(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.event = .message(v)
        }
      }()
      case 2: try {
        var v: Service_Auth?
        var hadOneofValue = false
        if let current = self.event {
          hadOneofValue = true
          if case .auth(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.event = .auth(v)
        }
      }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    switch self.event {
    case .message?: try {
      guard case .message(let v)? = self.event else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }()
    case .auth?: try {
      guard case .auth(let v)? = self.event else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }()
    case nil: break
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Service_StreamRequest, rhs: Service_StreamRequest) -> Bool {
    if lhs.event != rhs.event {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Service_Message: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
	public static let protoMessageName: String = _protobuf_package + ".Message"
	public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "recipient"),
    2: .same(proto: "id"),
    3: .same(proto: "from"),
    4: .same(proto: "to"),
    5: .same(proto: "type"),
    6: .same(proto: "status"),
    7: .standard(proto: "chat_type"),
    8: .standard(proto: "is_favorite"),
    9: .same(proto: "views"),
    10: .standard(proto: "created_at"),
    11: .standard(proto: "upated_at"),
    12: .standard(proto: "deleted_at"),
    13: .same(proto: "text"),
    14: .same(proto: "media"),
    15: .same(proto: "forward"),
    16: .same(proto: "quote"),
    17: .same(proto: "chronicle"),
    18: .same(proto: "profile"),
    19: .standard(proto: "profile_photo"),
    20: .same(proto: "moment"),
    21: .same(proto: "news"),
    22: .same(proto: "choose"),
  ]

  fileprivate class _StorageClass {
    var _recipient: [Int64] = []
    var _id: String = String()
    var _from: Int64 = 0
    var _to: Int64 = 0
    var _type: Service_MessageTypes = .text
    var _status: Service_MessageStatuses = .recieved
    var _chatType: Service_ChatTypes = .direct
    var _isFavorite: Bool = false
    var _views: Int64 = 0
    var _createdAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
    var _upatedAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
    var _deletedAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
    var _content: Service_Message.OneOf_Content?

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _recipient = source._recipient
      _id = source._id
      _from = source._from
      _to = source._to
      _type = source._type
      _status = source._status
      _chatType = source._chatType
      _isFavorite = source._isFavorite
      _views = source._views
      _createdAt = source._createdAt
      _upatedAt = source._upatedAt
      _deletedAt = source._deletedAt
      _content = source._content
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

	mutating public func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every case branch when no optimizations are
        // enabled. https://github.com/apple/swift-protobuf/issues/1034
        switch fieldNumber {
        case 1: try { try decoder.decodeRepeatedInt64Field(value: &_storage._recipient) }()
        case 2: try { try decoder.decodeSingularStringField(value: &_storage._id) }()
        case 3: try { try decoder.decodeSingularInt64Field(value: &_storage._from) }()
        case 4: try { try decoder.decodeSingularInt64Field(value: &_storage._to) }()
        case 5: try { try decoder.decodeSingularEnumField(value: &_storage._type) }()
        case 6: try { try decoder.decodeSingularEnumField(value: &_storage._status) }()
        case 7: try { try decoder.decodeSingularEnumField(value: &_storage._chatType) }()
        case 8: try { try decoder.decodeSingularBoolField(value: &_storage._isFavorite) }()
        case 9: try { try decoder.decodeSingularInt64Field(value: &_storage._views) }()
        case 10: try { try decoder.decodeSingularMessageField(value: &_storage._createdAt) }()
        case 11: try { try decoder.decodeSingularMessageField(value: &_storage._upatedAt) }()
        case 12: try { try decoder.decodeSingularMessageField(value: &_storage._deletedAt) }()
        case 13: try {
          var v: Service_MTText?
          var hadOneofValue = false
          if let current = _storage._content {
            hadOneofValue = true
            if case .text(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {
            if hadOneofValue {try decoder.handleConflictingOneOf()}
            _storage._content = .text(v)
          }
        }()
        case 14: try {
          var v: Service_MTMedia?
          var hadOneofValue = false
          if let current = _storage._content {
            hadOneofValue = true
            if case .media(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {
            if hadOneofValue {try decoder.handleConflictingOneOf()}
            _storage._content = .media(v)
          }
        }()
        case 15: try {
          var v: Service_MTForwardMessage?
          var hadOneofValue = false
          if let current = _storage._content {
            hadOneofValue = true
            if case .forward(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {
            if hadOneofValue {try decoder.handleConflictingOneOf()}
            _storage._content = .forward(v)
          }
        }()
        case 16: try {
          var v: Service_MTQuoteMessage?
          var hadOneofValue = false
          if let current = _storage._content {
            hadOneofValue = true
            if case .quote(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {
            if hadOneofValue {try decoder.handleConflictingOneOf()}
            _storage._content = .quote(v)
          }
        }()
        case 17: try {
          var v: Service_MTChronicle?
          var hadOneofValue = false
          if let current = _storage._content {
            hadOneofValue = true
            if case .chronicle(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {
            if hadOneofValue {try decoder.handleConflictingOneOf()}
            _storage._content = .chronicle(v)
          }
        }()
        case 18: try {
          var v: Service_MTProfile?
          var hadOneofValue = false
          if let current = _storage._content {
            hadOneofValue = true
            if case .profile(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {
            if hadOneofValue {try decoder.handleConflictingOneOf()}
            _storage._content = .profile(v)
          }
        }()
        case 19: try {
          var v: Service_MTProfilePhoto?
          var hadOneofValue = false
          if let current = _storage._content {
            hadOneofValue = true
            if case .profilePhoto(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {
            if hadOneofValue {try decoder.handleConflictingOneOf()}
            _storage._content = .profilePhoto(v)
          }
        }()
        case 20: try {
          var v: Service_MTMoment?
          var hadOneofValue = false
          if let current = _storage._content {
            hadOneofValue = true
            if case .moment(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {
            if hadOneofValue {try decoder.handleConflictingOneOf()}
            _storage._content = .moment(v)
          }
        }()
        case 21: try {
          var v: Service_MTNews?
          var hadOneofValue = false
          if let current = _storage._content {
            hadOneofValue = true
            if case .news(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {
            if hadOneofValue {try decoder.handleConflictingOneOf()}
            _storage._content = .news(v)
          }
        }()
        case 22: try {
          var v: Service_MTChoose?
          var hadOneofValue = false
          if let current = _storage._content {
            hadOneofValue = true
            if case .choose(let m) = current {v = m}
          }
          try decoder.decodeSingularMessageField(value: &v)
          if let v = v {
            if hadOneofValue {try decoder.handleConflictingOneOf()}
            _storage._content = .choose(v)
          }
        }()
        default: break
        }
      }
    }
  }

	public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if !_storage._recipient.isEmpty {
        try visitor.visitPackedInt64Field(value: _storage._recipient, fieldNumber: 1)
      }
      if !_storage._id.isEmpty {
        try visitor.visitSingularStringField(value: _storage._id, fieldNumber: 2)
      }
      if _storage._from != 0 {
        try visitor.visitSingularInt64Field(value: _storage._from, fieldNumber: 3)
      }
      if _storage._to != 0 {
        try visitor.visitSingularInt64Field(value: _storage._to, fieldNumber: 4)
      }
      if _storage._type != .text {
        try visitor.visitSingularEnumField(value: _storage._type, fieldNumber: 5)
      }
      if _storage._status != .recieved {
        try visitor.visitSingularEnumField(value: _storage._status, fieldNumber: 6)
      }
      if _storage._chatType != .direct {
        try visitor.visitSingularEnumField(value: _storage._chatType, fieldNumber: 7)
      }
      if _storage._isFavorite != false {
        try visitor.visitSingularBoolField(value: _storage._isFavorite, fieldNumber: 8)
      }
      if _storage._views != 0 {
        try visitor.visitSingularInt64Field(value: _storage._views, fieldNumber: 9)
      }
      if let v = _storage._createdAt {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 10)
      }
      if let v = _storage._upatedAt {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 11)
      }
      if let v = _storage._deletedAt {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 12)
      }
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch _storage._content {
      case .text?: try {
        guard case .text(let v)? = _storage._content else { preconditionFailure() }
        try visitor.visitSingularMessageField(value: v, fieldNumber: 13)
      }()
      case .media?: try {
        guard case .media(let v)? = _storage._content else { preconditionFailure() }
        try visitor.visitSingularMessageField(value: v, fieldNumber: 14)
      }()
      case .forward?: try {
        guard case .forward(let v)? = _storage._content else { preconditionFailure() }
        try visitor.visitSingularMessageField(value: v, fieldNumber: 15)
      }()
      case .quote?: try {
        guard case .quote(let v)? = _storage._content else { preconditionFailure() }
        try visitor.visitSingularMessageField(value: v, fieldNumber: 16)
      }()
      case .chronicle?: try {
        guard case .chronicle(let v)? = _storage._content else { preconditionFailure() }
        try visitor.visitSingularMessageField(value: v, fieldNumber: 17)
      }()
      case .profile?: try {
        guard case .profile(let v)? = _storage._content else { preconditionFailure() }
        try visitor.visitSingularMessageField(value: v, fieldNumber: 18)
      }()
      case .profilePhoto?: try {
        guard case .profilePhoto(let v)? = _storage._content else { preconditionFailure() }
        try visitor.visitSingularMessageField(value: v, fieldNumber: 19)
      }()
      case .moment?: try {
        guard case .moment(let v)? = _storage._content else { preconditionFailure() }
        try visitor.visitSingularMessageField(value: v, fieldNumber: 20)
      }()
      case .news?: try {
        guard case .news(let v)? = _storage._content else { preconditionFailure() }
        try visitor.visitSingularMessageField(value: v, fieldNumber: 21)
      }()
      case .choose?: try {
        guard case .choose(let v)? = _storage._content else { preconditionFailure() }
        try visitor.visitSingularMessageField(value: v, fieldNumber: 22)
      }()
      case nil: break
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

	public static func ==(lhs: Service_Message, rhs: Service_Message) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._recipient != rhs_storage._recipient {return false}
        if _storage._id != rhs_storage._id {return false}
        if _storage._from != rhs_storage._from {return false}
        if _storage._to != rhs_storage._to {return false}
        if _storage._type != rhs_storage._type {return false}
        if _storage._status != rhs_storage._status {return false}
        if _storage._chatType != rhs_storage._chatType {return false}
        if _storage._isFavorite != rhs_storage._isFavorite {return false}
        if _storage._views != rhs_storage._views {return false}
        if _storage._createdAt != rhs_storage._createdAt {return false}
        if _storage._upatedAt != rhs_storage._upatedAt {return false}
        if _storage._deletedAt != rhs_storage._deletedAt {return false}
        if _storage._content != rhs_storage._content {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Service_MessageResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".MessageResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "timestamp"),
    2: .same(proto: "message"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._timestamp) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._message) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._timestamp {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if let v = self._message {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Service_MessageResponse, rhs: Service_MessageResponse) -> Bool {
    if lhs._timestamp != rhs._timestamp {return false}
    if lhs._message != rhs._message {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Service_Auth: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Auth"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "token"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._token) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._token {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Service_Auth, rhs: Service_Auth) -> Bool {
    if lhs._token != rhs._token {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
