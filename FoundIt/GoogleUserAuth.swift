//
//  GoogleUserAuth.swift
//  FoundIt
//
//  Created by Joshua Ochalek on 11/29/23.
//

import SwiftUI
import GoogleSignIn

class GoogleUserAuth: ObservableObject {
    
    @Published var netId: String = "n/a"
    @Published var isLoggedIn: Bool = false
    @Published var name: String = "n/a"
    @Published var nonCornellLoggedIn: Bool = false
    @Published var imageUrl: String = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png"
    @Published var userId: Int = -1
    @Published var posts: [PostItem] = []
    
    func updatePosts() {
        NetworkManager.shared.addOrUpdateUser(netId: netId, name: name) { newUser in
            self.userId = newUser.id
            self.posts = []
            for post in newUser.posts {
                self.posts.append(PostItem(id: post.id, name: self.name, netID: self.netId, description: post.description, imageUrl: post.image_url))
            }
        }
    }
    
    func updateFields() {
        if GIDSignIn.sharedInstance.currentUser != nil {
            let profile = GIDSignIn.sharedInstance.currentUser!.profile!
            if (profile.email.hasSuffix("cornell.edu")) {
                netId = String(profile.email.prefix(upTo: profile.email.firstIndex(of: "@")!))
                imageUrl = profile.imageURL(withDimension: 48)?.absoluteString ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png"
                name = profile.name
                isLoggedIn = true
                nonCornellLoggedIn = true
                updatePosts()
            } else {
                netId = "Invalid Email"
                imageUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png"
                name = "n/a"
                isLoggedIn = false
                nonCornellLoggedIn = true
                userId = -1
            }
        } else {
            netId = "Invalid Email"
            imageUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png"
            name = "n/a"
            isLoggedIn = false
            nonCornellLoggedIn = false
            userId = -1
        }
    }
    
    func checkLogin() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            self.updateFields()
        }
    }
    
    func signIn() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { user, error in
            self.checkLogin()
        }
    }
    
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        self.checkLogin()
    }
}
