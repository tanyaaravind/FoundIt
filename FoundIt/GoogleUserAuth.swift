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
    
    init() {
        checkLogin()
    }
    
    func updateFields() {
        if GIDSignIn.sharedInstance.currentUser != nil {
            let email = GIDSignIn.sharedInstance.currentUser!.profile!.email
            if (email.hasSuffix("cornell.edu")) {
                netId = String(email.prefix(upTo: email.firstIndex(of: "@")!))
                isLoggedIn = true
            } else {
                netId = "Invalid Email"
                isLoggedIn = false
            }
        } else {
            netId = "n/a"
            isLoggedIn = false
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
