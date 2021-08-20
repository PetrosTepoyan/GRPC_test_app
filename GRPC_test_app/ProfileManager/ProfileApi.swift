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

// Энд поинты для работы с Profile
public enum ProfileApi {
    // Profiles
        case getAllProfiles(data: ProfileGetAll) // post
        case syncContacts // post
        case getCurrentProfile // get
        case createProfile(data: ProfileInput) // post
        case getProfileById(id: Int) // get
        case updateProfile(id: Int, data: ProfileInput) // put
        case getAvatarsByProfileId(id: Int, limit: Int, offset: Int) // get
        case createAvatarByProfileId(id: Int, data: AvatarRequest) // post
        case deleteAvatarByProfileId(id: Int, avatarId: Int) // delete
        case followersToByProfileId(id: Int, limit: Int, offset: Int) // get
        case followingByProfileId(id: Int, limit: Int, offset: Int) // get
        case followByProfileId(id: Int, followId: Int) // post
        case unfollowByProfileId(id: Int) // delete
        case loversByProfileId(id: Int, limit: Int, offset: Int) // get
        case setProfileLanguage(language: SetProfileLanguage) // post
        case setProfileLocation(location: SetProfileLocation) // post
        case setProfileRating(rating: SetProfileRating) // post
        case getPhotosByProfileId(id: Int, limit: Int, offset: Int) // get
        case uploadAvatarByProfileId(id: Int, data: AvatarRequest) // post
        case updatePhotoByProfileId(id: Int) // put
        case uploadPhotoByProfileId(id: Int, uploadData: PhotoRequest) // post
        case deletePhotoByProfileId(id: Int, photoId: Int) // delete
        case setCurrentAvatarByPhotoId(id: Int, photoId: Int) // post
        case setCurrentAvatar(id: Int, avatarId: Int) // put
        case getOldAvatarsByProfileId(id: Int) // get
        case getCurrentAvatar(id: Int) // get
        case oldUpdateProfileById(data: ProfileInput) // put
        case oldGetProfileById(id: Int) // get
        case getProfiles // get
        case getAvatarById(avatarId: Int) // get
        case getProfilesByIds(ids: Int) // get
        case searchProfiles(query: String) // get
        case searchProfilesById(id: Int) // get
}

// Экстеншен для формирования эндпоинта АСАП
extension ProfileApi : EndPointType {
    
    var environmentBaseURL : String {
         switch ProfileService.environment { //https://sfera-profile.stage.sfera-app.ru
         case .production: return "http://sfera-profile.stage.sfera-app.ru"
         case .qa: return "http://sfera-profile.stage.sfera-app.ru"
         case .staging: return "http://sfera-profile.stage.sfera-app.ru"
         }
     }
    
    public var baseUrl: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
                return url
    }
    
    public var path: String {
        switch self {
        case .getAllProfiles:
            return "/actions/profiles/all"
        case .syncContacts:
            return "/api/profile/syncContacts"
        case .getCurrentProfile:
            return "/api/profiles"
        case .createProfile:
            return "/api/profiles"
        case .getProfileById(id: let id):
            return "/api/profiles/\(id)"
        case .updateProfile(id: let id, data: _):
            return "/api/profiles/\(id)"
        case .getAvatarsByProfileId(id: let id, limit: _, offset: _):
            return "/api/profiles/\(id)/avatar"
        case .createAvatarByProfileId(id: let id, data: _):
            return "/api/profiles/\(id)/avatar"
        case .deleteAvatarByProfileId(id: let id, avatarId: _):
            return "/api/profiles/\(id)/avatar"
        case .followersToByProfileId(id: let id, limit: _, offset: _):
            return "/api/profiles/\(id)/avatar"
        case .followingByProfileId(id: let id, limit: _, offset: _):
            return "/api/profiles/\(id)/followers"
        case .followByProfileId(id: let id, followId: _):
            return "/api/profiles/\(id)/following"
        case .unfollowByProfileId(id: let id):
            return "/api/profiles/\(id)/following"
        case .loversByProfileId(id: let id, limit: _, offset: _):
            return "/api/profiles/\(id)/following/lovers"
        case .setProfileLanguage:
            return "/api/v1/set/profile/language"
        case .setProfileLocation:
            return "/api/v1/set/profile/location"
        case .setProfileRating:
            return "/api/v1/set/profile/rating"
        case .getPhotosByProfileId(id: let id, limit: _, offset: _):
            return "/api/v2/profiles/\(id)/avatar"
        case .uploadAvatarByProfileId(id: let id, data: _):
            return "/api/v2/profiles/\(id)/avatar"
        case .updatePhotoByProfileId(id: let id):
            return "/api/v2/profiles/\(id)/photos"
        case .uploadPhotoByProfileId(id: let id, uploadData: _):
            return "/api/v2/profiles/\(id)/photos"
        case .deletePhotoByProfileId(id: let id, photoId: _):
            return "/api/v2/profiles/\(id)/photos"
        case .setCurrentAvatarByPhotoId(id: let id, photoId: _):
            return "/api/v2/profiles/\(id)/photos/setCurrentAvatarByPhotoId"
        case .setCurrentAvatar(id: let id, avatarId: let avId):
            return "/old/profile/\(id)/avatar/\(avId)"
        case .getOldAvatarsByProfileId(id: let id):
            return "/old/profile/\(id)/avatars"
        case .getCurrentAvatar(id: let id):
            return "/old/profile/\(id)/avatars/current"
        case .oldUpdateProfileById:
            return "/old/profiles/"
        case .oldGetProfileById:
            return "/old/profiles/add/"
        case .getProfiles:
            return "/old/profiles/all/"
        case .getAvatarById:
            return "/old/profiles/getAvatarById/"
        case .getProfilesByIds:
            return "/old/profiles/getProfiles/"
        case .searchProfiles:
            return "/old/profiles/search/"
        case .searchProfilesById:
            return "/old/profiles/searchById/"
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .getAllProfiles:
            return .post
        case .syncContacts:
            return .post
        case .getCurrentProfile:
            return .get
        case .createProfile:
            return .post
        case .getProfileById:
            return .get
        case .updateProfile:
            return .put
        case .getAvatarsByProfileId:
            return .get
        case .createAvatarByProfileId:
            return .post
        case .deleteAvatarByProfileId:
            return .delete
        case .followersToByProfileId:
            return .get
        case .followingByProfileId:
            return .get
        case .followByProfileId:
            return .post
        case .unfollowByProfileId:
            return .delete
        case .loversByProfileId:
            return .get
        case .setProfileLanguage:
            return .post
        case .setProfileLocation:
            return .post
        case .setProfileRating:
            return .post
        case .getPhotosByProfileId:
            return .get
        case .uploadAvatarByProfileId:
            return .post
        case .updatePhotoByProfileId:
            return .put
        case .uploadPhotoByProfileId:
            return .post
        case .deletePhotoByProfileId:
            return .delete
        case .setCurrentAvatarByPhotoId:
            return .post
        case .setCurrentAvatar:
            return .put
        case .getOldAvatarsByProfileId:
            return .get
        case .getCurrentAvatar:
            return .get
        case .oldUpdateProfileById:
            return .put
        case .oldGetProfileById:
            return .get
        case .getProfiles:
            return .get
        case .getAvatarById:
            return .get
        case .getProfilesByIds:
            return .get
        case .searchProfiles:
            return .get
        case .searchProfilesById:
            return .get
        }
    }
    
    public var httpTask: HTTPTask {
        switch self {
        case .getAllProfiles:
            return .request
        case .syncContacts:
            return .request
        case .getCurrentProfile:
            return .request
        case .createProfile:
            return .request
        case .getProfileById:
            return .request
        case .updateProfile:
            return .request
        case .getAvatarsByProfileId:
            return .request
        case .createAvatarByProfileId:
            return .request
        case .deleteAvatarByProfileId:
            return .request
        case .followersToByProfileId:
            return .request
        case .followingByProfileId:
            return .request
        case .followByProfileId:
            return .request
        case .unfollowByProfileId:
            return .request
        case .loversByProfileId:
            return .request
        case .setProfileLanguage:
            return .request
        case .setProfileLocation:
            return .request
        case .setProfileRating:
            return .request
        case .getPhotosByProfileId:
            return .request
        case .uploadAvatarByProfileId:
            return .request
        case .updatePhotoByProfileId:
            return .request
        case .uploadPhotoByProfileId:
            return .request
        case .deletePhotoByProfileId:
            return .request
        case .setCurrentAvatarByPhotoId:
            return .request
        case .setCurrentAvatar:
            return .request
        case .getOldAvatarsByProfileId:
            return .request
        case .getCurrentAvatar:
            return .request
        case .oldUpdateProfileById:
            return .request
        case .oldGetProfileById:
            return .request
        case .getProfiles:
            return .request
        case .getAvatarById:
            return .request
        case .getProfilesByIds:
            return .request
        case .searchProfiles:
            return .request
        case .searchProfilesById:
            return .request
        }
    }
    
    public var bodyParametrs: BodyParameters? {
        switch self {
        case .getAllProfiles(data: let data):
            do {
                let dictionary = try DictionaryEncoder().encode(data)
                return dictionary
            } catch  {
                return nil
            }
        case .syncContacts:
            return nil
        case .getCurrentProfile:
            return nil
        case .createProfile(data: let data):
            do {
                let dictionary = try DictionaryEncoder().encode(data)
                return dictionary
            } catch {
                return nil
            }
        case .getProfileById:
            return nil
        case .updateProfile(id: _, data: let data):
            do {
                let dictionary = try DictionaryEncoder().encode(data)
                return dictionary
            } catch {
                return nil
            }
        case .getAvatarsByProfileId:
            return nil
        case .createAvatarByProfileId(id: _, data: let data):
            do {
                let dictionary = try DictionaryEncoder().encode(data)
                return dictionary
            } catch {
                return nil
            }
        case .deleteAvatarByProfileId:
            return nil
        case .followersToByProfileId:
            return nil
        case .followingByProfileId:
            return nil
        case .followByProfileId:
            return nil
        case .unfollowByProfileId:
            return nil
        case .loversByProfileId:
            return nil
        case .setProfileLanguage(language: let data):
            do {
                let dictionary = try DictionaryEncoder().encode(data)
                return dictionary
            } catch {
                return nil
            }
        case .setProfileLocation(location: let data):
            do {
                let dictionary = try DictionaryEncoder().encode(data)
                return dictionary
            } catch {
                return nil
            }
        case .setProfileRating(rating: let data):
            do {
                let dictionary = try DictionaryEncoder().encode(data)
                return dictionary
            } catch {
                return nil
            }
        case .getPhotosByProfileId:
            return nil
        case .uploadAvatarByProfileId(id: _, data: let data):
            do {
                let dictionary = try DictionaryEncoder().encode(data)
                return dictionary
            } catch {
                return nil
            }
        case .updatePhotoByProfileId:
            return nil
        case .uploadPhotoByProfileId(id: _, uploadData: let data):
            do {
                let dictionary = try DictionaryEncoder().encode(data)
                return dictionary
            } catch {
                return nil
            }
        case .deletePhotoByProfileId:
            return nil
        case .setCurrentAvatarByPhotoId:
            return nil
        case .setCurrentAvatar:
            return nil
        case .getOldAvatarsByProfileId:
            return nil
        case .getCurrentAvatar:
            return nil
        case .oldUpdateProfileById(data: let data):
            do {
                let dictionary = try DictionaryEncoder().encode(data)
                return dictionary
            } catch {
                return nil
            }
        case .oldGetProfileById:
            return nil
        case .getProfiles:
            return nil
        case .getAvatarById:
            return nil
        case .getProfilesByIds:
            return nil
        case .searchProfiles:
            return nil
        case .searchProfilesById:
            return nil
        }
        
        
    }
    
    public var urlParameters: URLParameters? {
        switch self {
        case .getAllProfiles:
            return nil
        case .syncContacts:
            return nil
        case .getCurrentProfile:
            return nil
        case .createProfile:
            return nil
        case .getProfileById:
            return nil
        case .updateProfile:
            return nil
        case .getAvatarsByProfileId(id: _, limit: let limit, offset: let offset):
            return ["limit": limit,
                    "offset": offset]
        case .createAvatarByProfileId:
            return nil
        case .deleteAvatarByProfileId(id: _, avatarId: let avId):
            return ["avatarId": avId]
        case .followersToByProfileId(id: _, limit: let limit, offset: let offset):
            return ["limit": limit,
                    "offset": offset]
        case .followingByProfileId(id: _, limit: let limit, offset: let offset):
            return ["limit": limit,
                    "offset": offset]
        case .followByProfileId(id: _, followId: let followId):
            return ["followId": followId]
        case .unfollowByProfileId:
            return nil
        case .loversByProfileId(id: _, limit: let limit, offset: let offset):
            return ["limit": limit,
                    "offset": offset]
        case .setProfileLanguage:
            return nil
        case .setProfileLocation:
            return nil
        case .setProfileRating:
            return nil
        case .getPhotosByProfileId(id: _, limit: let limit, offset: let offset):
            return ["limit": limit,
                    "offset": offset]
        case .uploadAvatarByProfileId:
            return nil
        case .updatePhotoByProfileId:
            return nil
        case .uploadPhotoByProfileId:
            return nil
        case .deletePhotoByProfileId(id: _, photoId: let photoId):
            return ["photoId": photoId]
        case .setCurrentAvatarByPhotoId(id: _, photoId: let photoId):
            return ["photoId": photoId]
        case .setCurrentAvatar:
            return nil
        case .getOldAvatarsByProfileId:
            return nil
        case .getCurrentAvatar:
            return nil
        case .oldUpdateProfileById:
            return nil
        case .oldGetProfileById(id: let id):
            return ["profileId": id]
        case .getProfiles:
            return nil
        case .getAvatarById(avatarId: let avId):
            return ["avatarId": avId]
        case .getProfilesByIds(ids: let id):
            return ["ids": id]
        case .searchProfiles(query: let query):
            return["query": query]
        case .searchProfilesById(id: let id):
            return ["query": id]
        }
    }
    
    public var fields: Fields? {
        switch self {
        case .getAllProfiles:
            return ["accept" : "application/json",
                    "Content-Type" : "application/json"]
        case .syncContacts:
            return ["accept" : "application/json"]
        case .getCurrentProfile:
            return ["accept" : "application/json"]
        case .createProfile:
            return ["accept" : "application/json",
                    "Content-Type" : "application/json"]
        case .getProfileById:
            return ["accept" : "application/json"]
        case .updateProfile:
            return ["accept" : "application/json",
                    "Content-Type" : "application/json"]
        case .getAvatarsByProfileId:
            return ["accept" : "application/json"]
        case .createAvatarByProfileId:
            return ["accept" : "application/json",
                    "Content-Type" : "application/json"]
        case .deleteAvatarByProfileId:
            return ["accept" : "application/json"]
        case .followersToByProfileId:
            return ["accept" : "application/json"]
        case .followingByProfileId:
            return ["accept" : "application/json"]
        case .followByProfileId:
            return ["accept" : "application/json"]
        case .unfollowByProfileId:
            return ["accept" : "application/json"]
        case .loversByProfileId:
            return ["accept" : "application/json"]
        case .setProfileLanguage:
            return ["accept" : "application/json",
                    "Content-Type" : "application/json"]
        case .setProfileLocation:
            return ["accept" : "application/json",
                    "Content-Type" : "application/json"]
        case .setProfileRating:
            return ["accept" : "application/json",
                    "Content-Type" : "application/json"]
        case .getPhotosByProfileId:
            return ["accept" : "application/json"]
        case .uploadAvatarByProfileId:
            return ["accept" : "application/json",
                    "Content-Type" : "application/json"]
        case .updatePhotoByProfileId:
            return ["accept" : "application/json"]
        case .uploadPhotoByProfileId:
            return ["accept" : "application/json",
                    "Content-Type" : "application/json"]
        case .deletePhotoByProfileId:
            return ["accept" : "application/json"]
        case .setCurrentAvatarByPhotoId:
            return ["accept" : "application/json"]
        case .setCurrentAvatar:
            return ["accept" : "application/json"]
        case .getOldAvatarsByProfileId:
            return ["accept" : "application/json"]
        case .getCurrentAvatar:
            return ["accept" : "application/json"]
        case .oldUpdateProfileById:
            return ["accept" : "application/json",
                    "Content-Type" : "application/json"]
        case .oldGetProfileById:
            return ["accept" : "application/json"]
        case .getProfiles:
            return ["accept" : "application/json"]
        case .getAvatarById:
            return ["accept" : "application/json"]
        case .getProfilesByIds:
            return ["accept" : "application/json"]
        case .searchProfiles:
            return ["accept" : "application/json"]
        case .searchProfilesById:
            return ["accept" : "application/json"]
        }
    }
    
    public var httpHeaders: HTTPHeader? {
        return nil
    }
    
    
}

