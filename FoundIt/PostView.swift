//
//  PostView.swift
//  FoundIt
//
//  Created by Tanya Aravind on 11/30/23.
//

import SwiftUI
import PhotosUI

struct PostView: View {
    @State private var newPost: String = ""
    @State private var imagePickerPresented = false
    @State private var photoItem: PhotosPickerItem?
    
    var body: some View {
        VStack {
            HStack{
                Button {
                    print("Cancel")
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Text("New Post")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    print("Post")
                } label: {
                    Text("Post")
                }
                
            }
            .padding(.horizontal)
            
            HStack (spacing: 8) {
                Image("yellowhat")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                TextField("Report a Lost or Found Object", text: $newPost, axis: .vertical)
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            imagePickerPresented.toggle()
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $photoItem)
       
    }
    
}


#Preview {
    PostView()
}
