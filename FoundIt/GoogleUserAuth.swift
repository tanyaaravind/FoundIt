//
//  swift
//  FoundIt
//
//  Created by Joshua Ochalek on 11/29/23.
//

import SwiftUI
import GoogleSignIn

class GoogleUserAuth: ObservableObject {
    
    static let user: GoogleUserAuth = GoogleUserAuth()
    
    var netId: String = "n/a"
    var isLoggedIn: Bool = false
    var name: String = "n/a"
    var nonCornellLoggedIn: Bool = false
    var imageUrl: String = "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg"
    var userId: Int = -1
    
    func updateFields() {
        if GIDSignIn.sharedInstance.currentUser != nil {
            let profile = GIDSignIn.sharedInstance.currentUser!.profile!
            if (profile.email.hasSuffix("cornell.edu")) {
                netId = String(profile.email.prefix(upTo: profile.email.firstIndex(of: "@")!))
                imageUrl = profile.imageURL(withDimension: 48)?.absoluteString ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png"
                name = profile.name
                isLoggedIn = true
                nonCornellLoggedIn = true
                print("Test22")
                NetworkManager.shared.addOrUpdateUser() { newUser in
                    self.userId = newUser.id
                    print("test")
                    print(self.userId)
                }
            } else {
                netId = "Invalid Email"
                imageUrl = "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg"
                name = "n/a"
                isLoggedIn = false
                nonCornellLoggedIn = true
                userId = -1
            }
        } else {
            netId = "Invalid Email"
            imageUrl = "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg"
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
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        self.checkLogin()
    }
}
