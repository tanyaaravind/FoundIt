//
//  NetworkManager.swift
//  FoundIt
//
//  Created by Joshua Ochalek on 12/1/23.
//

import Alamofire
import SwiftUI
import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    private let endpoint: String = "http://34.145.155.95/api"
    
    func addOrUpdateUser(completion: @escaping (NewUser) -> Void) {
        
        print(GoogleUserAuth.user.netId)
        print(GoogleUserAuth.user.name)
        let parameters = [
            "netid": GoogleUserAuth.user.netId,
            "name": GoogleUserAuth.user.name
        ]
        
        AF.request("\(endpoint)/users/", method: .post, parameters: parameters)
            .validate()
            .responseDecodable(of: NewUser.self, decoder: JSONDecoder()) { response in
                switch response.result {
                    case .success(let user):
                        completion(user)
                    case .failure(let fail):
                        print("Error in adding user: \(fail)")
                }
            }
    }
    
    func createPost(description: String, imageUrl: String, completion: @escaping (Post) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let nowStamp = dateFormatter.string(from: Date.now)
        
        let parameters = [
            "description": description,
            "is_found": "false",
            "timestamp": nowStamp
        ]
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        AF.request("\(endpoint)/users/\(GoogleUserAuth.user.userId)/posts/", method: .post, parameters: parameters)
            .validate()
            .responseDecodable(of: Post.self, decoder: decoder) { response in
                switch response.result {
                    case .success(let post):
                        completion(post)
                    case .failure(let error):
                        // TODO: add error popup?
                        print("Error in creating post")
                }
            }
    }
}

extension Date {
    func convertToAgo() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

struct NewUser: Codable {
    var id: Int
    var name: String
    var netid: String
    var posts: [Post]
}
