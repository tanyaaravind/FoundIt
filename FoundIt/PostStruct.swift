//
//  PostStruct.swift
//  FoundIt
//
//  Created by Tanya Aravind on 11/30/23.
//

import SwiftUI

struct Post: Identifiable, Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.description = try container.decode(String.self, forKey: .description)
        self.is_found = try container.decode(Bool.self, forKey: .is_found)
        self.timestamp = try container.decode(String.self, forKey: .timestamp)
        self.image_url = try container.decode(String.self, forKey: .image_url)
    }
    var id: Int
    var description: String
    var is_found: Bool
    var timestamp: String
    var image_url: String	
}

//var lostPosts: [Post] = [
//    Post(name: "Tanya", netID: "ta374", description: "yellow beanie found in RPCC", image: Image("yellowhat")),
//    Post(name: "Joshua", netID: "fhruh", description: "beanie in yellow", image: Image("yellowhat")),
//    Post(name: "Winifred", netID: "fhruf", description: "knitted hat", image: Image("yellowhat")),
//    Post(name: "Daniel", netID: "jidlc", description: "hat", image: Image("yellowhat")),
//    Post(name: "Pablo", netID: "jcoep", description: "little hat thing found at Goldwin Smith", image: Image("yellowhat")),
//    Post(name: "Skye", netID: "ry8u5", description: "yellow hat left at Baker Hall 200", image: Image("yellowhat"))
//    ]
//
//var foundPosts: [Post] = [
//    Post(name: "Tanya", netID: "ta374", description: "yellow beanie found in RPCC", image: Image("greenhat")),
//    Post(name: "Joshua", netID: "fhruh", description: "beanie in yellow", image: Image("greenhat")),
//    Post(name: "Winifred", netID: "fhruf", description: "knitted hat", image: Image("greenhat")),
//    Post(name: "Daniel", netID: "jidlc", description: "hat", image: Image("greenhat")),
//    Post(name: "Pablo", netID: "jcoep", description: "little hat thing found at Goldwin Smith", image: Image("greenhat")),
//    Post(name: "Skye", netID: "ry8u5", description: "yellow hat left at Baker Hall 200", image: Image("greenhat"))
//    ]
