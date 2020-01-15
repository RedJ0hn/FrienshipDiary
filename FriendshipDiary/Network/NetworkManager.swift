//
//  ViewController.swift
//  FriendshipDiary
//
//  Created by Mateusz on 04/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    static let address = NetworkURL()
    
    static var sessionToken: String?
    
    private static var alamofireManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60
        return Session(configuration: configuration)
    }()
    
    private static func request(_ address: Link, method: HTTPMethod, parameters: Parameters? = nil, logMethod: Bool = true, successBlock: @escaping ([String:Any]?) -> (), failtureBlock: @escaping (ApiItemError?) -> ()) {
        let headers : HTTPHeaders = [
            "Authorization": "Bearer " + (sessionToken ?? ""),
            "Content-Type": "application/json"
        ]
        alamofireManager.request(address.full, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if logMethod {
                    print("\nRequest: \(address) \nWith parametres: \(parameters ?? [:]) \nJSON response: \(json)")
                }
                successBlock(json.dictionaryObject)
                
            case .failure(_):
                var error: ApiItemError?
                if let data = response.data {
                    error = try? JSONDecoder().decode(ApiItemError.self, from: data)
                }
                failtureBlock(error)
            }
        }
    }
    
    //MARK: - Before login
    
    static func login(userName: String, password: String, successBlock: @escaping ([String:Any]?)->(), failtureBlock: @escaping (ApiItemError?) -> ()) {
        let parameters: Parameters = [
            "username" : userName,
            "password" : password
        ]
        
        request(NetworkManager.address.postLogin, method: .post, parameters: parameters, successBlock: { (data) in
            successBlock(data)
        }) { (error) in
            failtureBlock(error)
        }
    }
    
    static func register(userName: String, password: String, firstName: String, lastName: String, successBlock: @escaping ([String:Any]?)->(), failtureBlock: @escaping (ApiItemError?) -> ()) {
        let parameters: Parameters = [
            "username" : userName,
            "password" : password,
            "lastname" : lastName,
            "firstname" : firstName
        ]
        
        request(NetworkManager.address.postRegister, method: .post, parameters: parameters, successBlock: { (data) in
            successBlock(data)
        }) { (error) in
            failtureBlock(error)
        }
    }
    
    static func getMemories(successBlock: @escaping ([String:Any]?)->(), failtureBlock: @escaping (ApiItemError?) -> ()) {
        request(NetworkManager.address.getMemories, method: .get, successBlock: { (data) in
            successBlock(data)
        }) { (error) in
            failtureBlock(error)
        }
    }
    
    static func getFriends(successBlock: @escaping ([String: Any]?) -> (), failtureBlock: @escaping (ApiItemError?) -> ()) {
        request(NetworkManager.address.getFriends, method: .get, successBlock: { (data) in
            successBlock(data)
        }) { (error) in
            failtureBlock(error)
        }
    }
    
    static func getUsers(successBlock: @escaping ([String: Any]?) -> (), failtureBlock: @escaping (ApiItemError?) -> ()) {
        request(NetworkManager.address.getUsers, method: .get, successBlock: { (data) in
            successBlock(data)
        }) { (error) in
            failtureBlock(error)
        }
    }
    
    static func addFriend(username: String, successBlock: @escaping ([String: Any]?) -> (), failtureBlock: @escaping (ApiItemError?) -> ()) {
        request(NetworkManager.address.postFriend(username: username), method: .post, successBlock: { (data) in
            successBlock(data)
        }) { (error) in
            failtureBlock(error)
        }
    }
    
    static func deleteFriend(username: String, successBlock: @escaping ([String: Any]?) -> (), failtureBlock: @escaping (ApiItemError?) -> ()) {
        request(NetworkManager.address.deleteFriend(username: username), method: .delete, successBlock: { (data) in
            successBlock(data)
        }) { (error) in
            failtureBlock(error)
        }
    }
    
    static func postMemory(title: String, description: String, image: String, friends: [String], latitude: Double, longitude: Double, successBlock: @escaping ([String: Any]?) -> (), failtureBlock: @escaping (ApiItemError?) -> ()) {
        let localization = [ "latitude": latitude, "longitude" : longitude]
        let parameters: Parameters = [
            "title": title,
            "description": description,
            "image": image,
            "friends": friends,
            "localization": localization
        ]
        request(NetworkManager.address.postMemory, method: .post, parameters: parameters, successBlock: { (data) in
            successBlock(data)
        }) { (error) in
            failtureBlock(error)
        }
    }
    
    static func postDraft(title: String, description: String, image: String, friends: [String], latitude: Double, longitude: Double, successBlock: @escaping ([String: Any]?) -> (), failtureBlock: @escaping (ApiItemError?) -> ()) {
        let localization = [ "latitude": latitude, "longitude" : longitude]
        let parameters: Parameters = [
            "title": title,
            "description": description,
            "image": image,
            "friends": friends,
            "localization": localization
        ]
        request(NetworkManager.address.postMemoriesDraft, method: .post, parameters: parameters, successBlock: { (data) in
            successBlock(data)
        }) { (error) in
            failtureBlock(error)
        }
    }
        
}
