//
//  PostStruct.swift
//  FoundIt
//
//  Created by Tanya Aravind on 11/30/23.
//

import SwiftUI

struct Post: Identifiable {
    var id = UUID()
    var name: String
    var netID: String
    var description: String
    var image: Image
    }

var userClasses: [Post] = [
        Post(name: "Tanya", netID: "ta374", description: "yellow beanie", image: Image("yellowhat"))
    ]
