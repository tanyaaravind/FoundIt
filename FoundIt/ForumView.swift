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
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $searchBar)
                        .padding(.vertical, 10)
                }
                .padding()
                .background(Color.gray)
                .cornerRadius(36)
                .padding(.top, 15)
                .padding(.trailing, 10)
                .padding(.leading, 10)
                
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
                
            }
        }
    }
}

#Preview {
    ForumView()
}
