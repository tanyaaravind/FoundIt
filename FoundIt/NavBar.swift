//
//  NavBar.swift
//  FoundIt
//
//  Created by Tanya Aravind on 11/30/23.
//

import SwiftUI

struct NavBar: View {
    
    @State private var tab = 3
    @EnvironmentObject var user: GoogleUserAuth
    
    var body: some View {
        ZStack {
            TabView(selection: $tab) {
                // Home Tab
                ForumView()
                    .onAppear {
                        tab = 1
                    }
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(1)
                
                // Add Post Tab
                // TODO: convert image to base64
                PostView(tabIndex: $tab)
                    .onAppear {
                        tab = 2
                    }
                    .tabItem {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Post")
                    }
                    .tag(2)
                
                // Profile Tab
                ProfileView()
                    .onAppear {
                        tab = 3
                    }
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                        Text("Profile")
                    }
                    .tag(3)
            }
            VStack {
                Spacer()
                if !user.isLoggedIn {
                    Rectangle()
                        .fill(Color.white.opacity(0.001))
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 50)
                }
            }
        }
    }
}


#Preview {
    NavBar()
}
