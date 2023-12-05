//
//  PostStruct.swift
//  FoundIt
//
//  Created by Tanya Aravind on 11/30/23.
//

import Foundation

struct Post: Identifiable, Codable {
    var id: Int
    var description: String
    var is_found: Bool
    var user_id: Int?
    var timestamp: String
    var image_url: String
}
