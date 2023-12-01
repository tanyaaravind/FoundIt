//
//  FoundItApp.swift
//  FoundIt
//
//  Created by Tanya Aravind on 11/29/23.
//

import SwiftUI

@main
struct FoundItApp: App {
    
    @StateObject var googleUser: GoogleUserAuth = GoogleUserAuth()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(googleUser)
    }
}
