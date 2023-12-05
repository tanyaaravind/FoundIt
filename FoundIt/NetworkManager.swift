//
//  NetworkManager.swift
//  FoundIt
//
//  Created by Joshua Ochalek on 12/5/23.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private let endpoint: String = "http://34.145.155.95/api"
        
    func addOrUpdateUser(netId: String, name: String, completion: @escaping (NewUser) -> Void) {
        let parameters = [
            "netid": netId,
            "name": name
        ]
        
        AF.request("\(endpoint)/users/", method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
    
    func createPost(description: String, imageUrl: String, userId: Int, completion: @escaping (Post) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let nowStamp = dateFormatter.string(from: Date.now)
        
        let parameters: [String: Any] = [
            "description": description,
            "is_found": false,
            "timestamp": nowStamp,
            "image_data": imageUrl
        ]
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        AF.request("\(endpoint)/users/\(userId)/posts/", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: Post.self, decoder: decoder) { response in
                switch response.result {
                    case .success(let post):
                        completion(post)
                    case .failure(let error):
                        // TODO: add error popup?
                        print("Error in creating post: \(error.localizedDescription)")
                }
            }
    }
    
    func fetchPosts(type: String, completion: @escaping ([Post]) -> Void) {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        AF.request("\(endpoint)/posts/\(type)", method: .get, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: PostsFetchable.self, decoder: decoder) { response in
                switch response.result {
                    case .success(let fetch):
                        completion(fetch.posts)
                    case .failure(let error):
                        // TODO: add error popup?
                        print("Error in fetching \(type) posts: \(error.localizedDescription)")
                }
            }
    }
    
    func fetchUserById(id: Int, completion: @escaping (NewUser) -> Void) {
        AF.request("\(endpoint)/users/\(id)", method: .get, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: NewUser.self, decoder: JSONDecoder()) { response in
                switch response.result {
                    case .success(let user):
                        completion(user)
                    case .failure(let error):
                        // TODO: add error popup?
                        print("Error in fetching user: \(error.localizedDescription)")
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

struct PostsFetchable: Codable {
    var posts: [Post]
}
