//
//  ForumView.swift
//  FoundIt
//
//  Created by Tanya Aravind on 11/29/23.
//

import SwiftUI

struct ForumView: View {
    @State private var searchBar: String = ""
    @State private var currPosts: [Post]!
    @State private var postObjs: [PostItem] = []
    @EnvironmentObject var user: GoogleUserAuth
    
    enum ButtonType {
        case Lost, Found
    }
    
    @State private var selectedButton: ButtonType = .Lost

    private func fetch(type: String) {
        postObjs = []
        NetworkManager.shared.fetchPosts(type: type) { posts in
            for post in posts {
                NetworkManager.shared.fetchUserById(id: post.user_id!) { newUser in
                    postObjs.append(PostItem(id: post.id, name: newUser.name, netID: newUser.netid, description: post.description, imageUrl: post.image_url))
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
                        
                    } label: {
                        Image(systemName: "bell")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 15)
                            .padding(.bottom, 10)
                    }
                    .foregroundStyle(Color.black)
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
                            self.selectedButton = .Lost
                            fetch(type: "lost")
                        } label: {
                            Text("Lost Items")
                                .font(.footnote)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(Color.primaryText)
                        }
                        .padding()
                        .background(selectedButton == .Lost ? Color.selectedGray : Color.lightBlue)
                        .cornerRadius(10)
                        
                        Spacer()
                        
                        Button {
                            self.selectedButton = .Found
                            fetch(type: "found")
                        } label: {
                            Text("Found Items")
                                .font(.footnote)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(Color.primaryText)
                        }
                        .padding()
                        .background(selectedButton == .Found ? Color.selectedGray : Color.lightBlue)
                        .cornerRadius(10)
                        
                        Spacer()
                        
                    }
                    .padding()
                    
                    ScrollView {
                        VStack() {
                            ForEach(postObjs) { post in
                                post
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    Spacer()
                       
                }
                
            }
        }
        .onAppear {
            if selectedButton == .Found {
                fetch(type: "found")
            } else {
                fetch(type: "lost")
            }
        }
    }
}

#Preview {
    ForumView()
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
 
