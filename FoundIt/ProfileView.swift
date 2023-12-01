//
//  ProfileView.swift
//  FoundIt
//
//  Created by Joshua Ochalek on 11/30/23.
//

import SwiftUI

struct ProfileView: View {
    @State private var searchBar: String = ""
    
    enum ProfileButtonType {
        case Current, Deleted
       }
    
    @State private var selectedButton: ProfileButtonType = .Current

    private func handleAuthentication() {
        GoogleUserAuth.user.checkLogin()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if !GoogleUserAuth.user.isLoggedIn {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    GoogleUserAuth.user.signIn()
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
                        GoogleUserAuth.user.signOut()
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
                    HStack {
                        Spacer()
                        
                        Button {
                            self.selectedButton = .Current
                        } label: {
                            Text("Your Posts")
                                .font(.footnote)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(Color.primaryText)
                        }
                        .padding()
                        .background(selectedButton == .Current ? Color.selectedGray : Color.lightBlue)
                        .cornerRadius(10)
                        
                        Spacer()
                        
                        Button {
                            self.selectedButton = .Deleted
                        } label: {
                            Text("Deleted Posts")
                                .font(.footnote)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(Color.primaryText)
                        }
                        .padding()
                        .background(selectedButton == .Deleted ? Color.selectedGray : Color.lightBlue)
                        .cornerRadius(10)
                        
                        Spacer()
                    }
                    .padding()
                    
                    ZStack {
                        VStack {
                            
                            HStack {
                                AsyncImage(url: URL(string: GoogleUserAuth.user.imageUrl))
                                    .frame(width: 48, height: 48)
                                    .cornerRadius(24)
                                Text("\(GoogleUserAuth.user.name) (\(GoogleUserAuth.user.netId))")
                            }
                            
                            // Display data based on the selected button
                            if selectedButton == .Current {
                                Text("Current")
                                    .padding()
                            } else {
                                Text("Deleted")
                                    .padding()
                            }
                        }
                        .opacity(GoogleUserAuth.user.isLoggedIn ? 1 : 0)
                        Button {
                            print(GoogleUserAuth.user.isLoggedIn)
                            GoogleUserAuth.user.signIn()
                        } label: {
                            Text("Sign In to FoundIt")
                                .padding()
                                .background(Color.lightBlue)
                                .cornerRadius(12)
                        }
                        .opacity(GoogleUserAuth.user.nonCornellLoggedIn ? 0 : 1)
                    }
                    
                    Spacer()
                }
//                .navigationTitle("Recover")
                
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
