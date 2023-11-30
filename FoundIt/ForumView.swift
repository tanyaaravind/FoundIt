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
           case Lost, Found
       }
    
    @State private var selectedButton: ButtonType = .Lost


    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    
                    Image(systemName: "bell")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 15)
                        .padding(.bottom, 10)
                }
                .padding(.top, 200)
                .background(Color.lightBlue)
                .cornerRadius(24, corners: [.bottomLeft, .bottomRight])
                .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Spacer()
                        Button("Lost") {
                            self.selectedButton = .Lost
                        }
                        .padding()
                        .frame(width: 90)
                        .background(selectedButton == .Lost ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        Spacer()
                        
                        Spacer()
                        Button("Found") {
                            self.selectedButton = .Found
                        }
                        .padding()
                        .frame(width: 90)
                        .background(selectedButton == .Found ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        Spacer()
                    }
                    .padding()
                    
                    // Display data based on the selected button
                    if selectedButton == .Lost {
                        Text("Lost")
                            .padding()
                    } else {
                        Text("Found")
                            .padding()
                    }
                    
                    Spacer()
                }
                .navigationTitle("Recover")
                .searchable(text: $searchBar, placement: .navigationBarDrawer(displayMode: .always))
                
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
 
