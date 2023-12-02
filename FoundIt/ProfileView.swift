//
//  ProfileView.swift
//  FoundIt
//
//  Created by Joshua Ochalek on 11/30/23.
//

import SwiftUI

struct ProfileView: View {
    @State private var searchBar: String = ""
    @EnvironmentObject var user: GoogleUserAuth

    private func handleAuthentication() {
        user.checkLogin()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if !user.isLoggedIn {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    user.signIn()
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $searchBar)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.top, 15)
                    .padding(.trailing, 10)
                    .padding(.leading, 15)
                    .padding(.bottom, 25)
                    
                    Spacer()
                    
                    Button {
                        user.signOut()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 15)
                            .padding(.bottom, 10)
                            .foregroundStyle(Color.black)
                    }
                }
                .padding(.top, 50)
                .background(Color.lightBlue)
                .cornerRadius(24, corners: [.bottomLeft, .bottomRight])
                .ignoresSafeArea()
                .padding(.bottom, -65)
                
                VStack {
                    
                    ZStack {
                        VStack {
                            
                            HStack {
                                AsyncImage(url: URL(string: user.imageUrl))
                                    .cornerRadius(24)
                                Text("\(user.name) (\(user.netId))")
                            }
                            .padding(.top, 20)
                            
                        }
                        .opacity(user.isLoggedIn ? 1 : 0)
                        Button {
                            user.signIn()
                        } label: {
                            Text("Sign In to FoundIt")
                                .padding()
                                .background(Color.lightBlue)
                                .cornerRadius(12)
                        }
                        .opacity(user.nonCornellLoggedIn ? 0 : 1)
                    }
                    
                    
                    VStack {
                        
                        HStack {
                            
                            Spacer()
                        
                            ScrollView {
                                VStack() {
                                    ForEach(myPosts) { myPost in
                                        PostItem(name: myPost.name, netID: myPost.netID, description: myPost.description, image: myPost.image)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                            }
                                .padding()
                        }
                        
                        Spacer()
                    }
                    //                .navigationTitle("Recover")
                    
                }
                
            }
        }
        .onAppear {
            handleAuthentication()
        }
    }
}

#Preview {
    ProfileView()
}
