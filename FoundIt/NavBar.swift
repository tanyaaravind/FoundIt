//
//  NavBar.swift
//  FoundIt
//
//  Created by Tanya Aravind on 11/30/23.
//

import SwiftUI

struct NavBar: View {
    var body: some View {
        TabView {
            // Home Tab
            ForumView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            // Schedule Tab
            Text("Post")
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Post")
                }
            
            // Locations Tab
            Text("Profile")
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
        }
    }
}


#Preview {
    NavBar()
}
