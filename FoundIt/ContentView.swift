//
//  ContentView.swift
//  FoundIt
//
//  Created by Tanya Aravind on 11/29/23.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn

struct ContentView: View {
    
    @EnvironmentObject var user: GoogleUserAuth
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button {
                user.signIn()
            } label: {
                Text(user.netId)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
