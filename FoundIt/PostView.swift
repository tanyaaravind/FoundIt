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
    @State private var showingPhotoOption: Bool = false
    @State private var photoItem: PhotosPickerItem?
    @State private var showingPhotoGallery: Bool = false
    @State private var image = UIImage(named: "emptyImage")
    @State private var showingCamera: Bool = false
    @EnvironmentObject var user: GoogleUserAuth
    @Binding var tabIndex: Int
    
    func toBase64 (image: UIImage) -> String {
        return "data:image/jpeg;base64,\(image.jpegData(compressionQuality: 1)?.base64EncodedString() ?? "")" 
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    image = UIImage(named: "emptyImage")
                    tabIndex = 1
                    newPost = ""
                } label: {
                    Text("Cancel")
                }
                
                //Spacer()
                Text("New Post")
                    .fontWeight(.semibold)
                    .font(.title)
                    .frame(width: 150, height: 50)
                    .background(Color.cyan)
                    .cornerRadius(12)
                    .padding(.leading, 35)
                    .padding(.trailing, 50)
                
                //Spacer()
                
                Button {
                    if image != UIImage(named: "emptyImage") {
                        NetworkManager.shared.createPost(description: newPost, imageUrl: toBase64(image: image!), userId: user.userId) { _ in
                            image = UIImage(named: "emptyImage")
                            tabIndex = 1
                            newPost = ""
                        }
                    }
                } label: {
                    Text("Post")
                }
                
            }
            .padding(.top, 80)
            .frame(maxWidth: .infinity)
            .frame(height: 160)
            .background(Color.lightBlue)
            .cornerRadius(24, corners: [.bottomLeft, .bottomRight])
            .ignoresSafeArea()
            .padding(.bottom, -55)
            
            VStack (spacing: 8) {
                Button {
                    showingPhotoOption.toggle()
                } label: {
                    Image(uiImage: image!)
                        .resizable()
                        .frame(width: 300, height: 300)
                        .cornerRadius(12)
                        .clipped()
                }
                .confirmationDialog("Select a method", isPresented: $showingPhotoOption, titleVisibility: .visible) {
                    Button("New Photo") {
                        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                            showingCamera.toggle()
                        }
                    }
                    Button("Existing Photo") {
                        showingPhotoGallery.toggle()
                    }
                }
                .photosPicker(isPresented: $showingPhotoGallery, selection: $photoItem)
                TextField("Report a Lost or Found Object", text: $newPost, axis: .vertical)
                    .lineLimit(4)
                    .frame(width: 300)
            }
            .padding()
            
            Spacer()
        }
        .fullScreenCover(isPresented: $showingCamera) {
            CameraView() { image in
                self.image = image
                showingCamera = false
                photoItem = nil
            }
        }
        .onChange(of: photoItem, initial: true) { _ , image in
            Task {
                showingPhotoGallery = false
                if let data = try? await image?.loadTransferable(type: Data.self) {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
    
}


#Preview {
    PostView(tabIndex: .constant(0))
}

