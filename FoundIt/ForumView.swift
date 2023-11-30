//
//  ForumView.swift
//  FoundIt
//
//  Created by Tanya Aravind on 11/29/23.
//

import SwiftUI

struct ForumView: View {
    @State private var searchBar: String = ""
    
    enum ButtonType {
           case Lost, Found, Latest
       }
    
    @State private var selectedButton: ButtonType = .Lost


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
                    
                    Image(systemName: "bell")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 15)
                        .padding(.bottom, 10)
                }
                .padding(.top, 50)
                .background(Color.lightBlue)
                .cornerRadius(24, corners: [.bottomLeft, .bottomRight])
                .ignoresSafeArea()
                .padding(.bottom, -65)
                
                VStack {
                    HStack {
                        Button {
                            self.selectedButton = .Lost
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
                        
                        Button {
                            self.selectedButton = .Latest
                        } label: {
                            Text("Latest Posts")
                                .font(.footnote)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(Color.primaryText)
                        }
                        .padding()
                        .background(selectedButton == .Latest ? Color.selectedGray : Color.lightBlue)
                        .cornerRadius(10)
                    }
                    .padding()
                    // Display data based on the selected button
                    if selectedButton == .Lost {
                        Text("Lost")
                            .padding()
                    } else if selectedButton == .Found {
                        Text("Found")
                            .padding()
                    } else {
                        Text("Latest")
                            .padding()
                    }
                    
                    Spacer()
                }
//                .navigationTitle("Recover")
                
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
