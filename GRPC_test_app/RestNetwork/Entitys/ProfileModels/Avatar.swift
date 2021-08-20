//
//  File.swift
//  
//
//  Created by Anton Yaroshchuk on 30.07.2021.
//

import Foundation

public struct Avatar: Codable {
    public var createdAt: String
    public var data: String
    public var fileName: String
    public var id: Int
    public var isDownloadQueued: Bool
    public var isDownloaded: Bool
    public var large: String
    public var localPath: String
    public var mediaFileId: Int
    public var mediaResourceId: Int
    public var medium: String
    public var mimeType: String
    public var orig: String
    public var path: String
    public var preview: String
    public var small: String
    public var text: String
    public var type: String
    public var updatedAt: String
    public var url: String
    
    public init(createdAt: String, data: String, fileName: String, id: Int, isDownloadQueued: Bool,
                isDownloaded: Bool, large: String, localPath: String, mediaFileId: Int, mediaResourceId: Int,
                medium: String, mimeType: String, orig: String, path: String, preview: String, small: String,
                text: String, type: String, updatedAt: String, url: String) {
        self.createdAt = createdAt
        self.data = data
        self.fileName = fileName
        self.id = id
        self.isDownloadQueued = isDownloadQueued
        self.isDownloaded = isDownloaded
        self.large = large
        self.localPath = localPath
        self.mediaFileId = mediaFileId
        self.mediaResourceId = mediaResourceId
        self.medium = medium
        self.mimeType = mimeType
        self.orig = orig
        self.path = path
        self.preview = preview
        self.small = small
        self.text = text
        self.type = type
        self.updatedAt = updatedAt
        self.url = url
        
    }
    
    public enum CodingKeys: String, CodingKey {
        case createdAt = "created_At"
        case data
        case fileName = "file_Name"
        case id = "id"
        case isDownloadQueued = "is_Download_Queued"
        case isDownloaded = "is_Downloaded"
        case large
        case localPath = "local_Path"
        case mediaFileId = "media_FileId"
        case mediaResourceId = "media_Resource_Id"
        case medium
        case mimeType = "mime_Type"
        case orig
        case path
        case preview
        case small
        case text
        case type
        case updatedAt = "updated_At"
        case url
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        data = try container.decode(String.self, forKey: .data)
        fileName = try container.decode(String.self, forKey: .fileName)
        id = try container.decode(Int.self, forKey: .id)
        isDownloadQueued = try container.decode(Bool.self, forKey: .isDownloadQueued)
        isDownloaded = try container.decode(Bool.self, forKey: .isDownloaded)
        large = try container.decode(String.self, forKey: .large)
        localPath = try container.decode(String.self, forKey: .localPath)
        mediaFileId = try container.decode(Int.self, forKey: .mediaFileId)
        mediaResourceId = try container.decode(Int.self, forKey: .mediaResourceId)
        medium = try container.decode(String.self, forKey: .medium)
        mimeType = try container.decode(String.self, forKey: .mimeType)
        orig = try container.decode(String.self, forKey: .orig)
        path = try container.decode(String.self, forKey: .path)
        preview = try container.decode(String.self, forKey: .preview)
        small = try container.decode(String.self, forKey: .small)
        text = try container.decode(String.self, forKey: .text)
        type = try container.decode(String.self, forKey: .type)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
        url = try container.decode(String.self, forKey: .url)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(data, forKey: .data)
        try container.encodeIfPresent(fileName, forKey: .fileName)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(isDownloadQueued, forKey: .isDownloadQueued)
        try container.encodeIfPresent(isDownloaded, forKey: .isDownloaded)
        try container.encodeIfPresent(large, forKey: .large)
        try container.encodeIfPresent(localPath, forKey: .localPath)
        try container.encodeIfPresent(mediaFileId, forKey: .mediaFileId)
        try container.encodeIfPresent(mediaResourceId, forKey: .mediaResourceId)
        try container.encodeIfPresent(medium, forKey: .medium)
        try container.encodeIfPresent(mimeType, forKey: .mimeType)
        try container.encodeIfPresent(orig, forKey: .orig)
        try container.encodeIfPresent(path, forKey: .path)
        try container.encodeIfPresent(preview, forKey: .preview)
        try container.encodeIfPresent(small, forKey: .small)
        try container.encodeIfPresent(text, forKey: .text)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(updatedAt, forKey: .updatedAt)
        try container.encodeIfPresent(url, forKey: .url)
    }
}
